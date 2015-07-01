class CommentsMailer < ApplicationMailer

	def notify_post_owner(comment)
		@comment = comment
		@post = comment.post
		mail(to: @post.user.email, subject: "A post has been commented on!")
	end
end
