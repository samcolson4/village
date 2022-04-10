class SubmissionController < ApplicationController

  def index
    @submissions = Submission.all

    @todays_posts = []
    unused_posts = []

    # find posts that have not been used
    for submission in @submissions do
      if !submission.used
        unused_posts.append(submission)
      end
    end

    # get the top 25% of the unused posts by score
    unused_posts.sort_by { |post| post.score }
    quarter = (unused_posts.length() / 4)
    posts_to_check = unused_posts[0..quarter]

    unused_posts.each_with_index do |post, i|
      if post.image_url == nil
        unused_posts.delete_at(i)
      end
    end

    if unused_posts.length >= 8
      8.times do
        @todays_posts.append(unused_posts.shuffle!.pop)
      end
    else
      unused_posts.length.times do
        @todays_posts.append(unused_posts.shuffle!.pop)
      end
    end

    @css_random = build_random_css()

    return @todays_posts, @css_random
  end

  def new
    @submission = Submission.new
  end

  def create
    @submission = Submission.new(submission_params)

    # Generate image
    # tmp_object = LinkThumbnailer.generate(@submission.url)
    # @submission.image_url = tmp_object.images.first.src.to_s

    if hasFields(@submission) && hasUniqueUrl(@submission)
      @submission.save
      redirect_to root_path, notice: "Thank you for submitting a new notice."
    else
      redirect_to submissions_new_path, alert: "There was an error submitting your notice."
    end
  end

private
  def hasFields(object)
    object.headline != nil
    object.url != nil
  end

  def hasUniqueUrl(object)
    @submissions = Submission.all

    @submissions.each do |submission|
      if object.url == submission.url
        p "URL is not unique"
        return false
      end
    end

    return true
  end

  def submission_params
    params.require(:submission).permit(:headline, :url)
  end

  def build_random_css
    output = []
    output.append(rand(0..7))

    7.times do
      random_num = rand(0..7)

      if output[-1] == random_num && random_num < 7
        output.append(random_num+1)
      elsif output[-1] == random_num && random_num == 7
        output.append(random_num-1)
      else
        output.append(random_num)
      end
    end

    return output
  end

end
