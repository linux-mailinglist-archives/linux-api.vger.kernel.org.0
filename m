Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90D21D6785
	for <lists+linux-api@lfdr.de>; Sun, 17 May 2020 12:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgEQKrb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 17 May 2020 06:47:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56066 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgEQKra (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 17 May 2020 06:47:30 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jaGpB-0006im-8W; Sun, 17 May 2020 10:47:17 +0000
Date:   Sun, 17 May 2020 12:47:01 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        tycho@tycho.ws, cyphar@cyphar.com
Subject: Re: [PATCH] seccomp: Add group_leader pid to seccomp_notif
Message-ID: <20200517104701.bbn2d2rqaplwchdw@wittgenstein>
References: <20200515234005.32370-1-sargun@sargun.me>
 <202005162344.74A02C2D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202005162344.74A02C2D@keescook>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, May 17, 2020 at 12:17:14AM -0700, Kees Cook wrote:
> On Fri, May 15, 2020 at 04:40:05PM -0700, Sargun Dhillon wrote:
> > This includes the thread group leader ID in the seccomp_notif. This is
> > immediately useful for opening up a pidfd for the group leader, as
> > pidfds only work on group leaders.
> > 
> > Previously, it was considered to include an actual pidfd in the
> > seccomp_notif structure[1], but it was suggested to avoid proliferating
> > mechanisms to create pidfds[2].
> > 
> > [1]: https://lkml.org/lkml/2020/1/24/133
> > [2]: https://lkml.org/lkml/2020/5/15/481
> 
> nit: please use lore.kernel.org/lkml/ URLs
> 
> > Suggested-by: Christian Brauner <christian.brauner@ubuntu.com>
> > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > ---
> >  include/uapi/linux/seccomp.h                  |  2 +
> >  kernel/seccomp.c                              |  1 +
> >  tools/testing/selftests/seccomp/seccomp_bpf.c | 50 +++++++++++++++++++
> >  3 files changed, 53 insertions(+)
> > 
> > diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> > index c1735455bc53..f0c272ef0f1e 100644
> > --- a/include/uapi/linux/seccomp.h
> > +++ b/include/uapi/linux/seccomp.h
> > @@ -75,6 +75,8 @@ struct seccomp_notif {
> >  	__u32 pid;
> >  	__u32 flags;
> >  	struct seccomp_data data;
> > +	__u32 tgid;
> > +	__u8 pad0[4];
> >  };
> 
> I think we need to leave off padding and instead use __packed. If we
> don't then userspace can't tell when "pad0" changes its "meaning" (i.e.
> the size of seccomp_notif becomes 88 bytes with above -- either via
> explicit padding like you've got or via implicit by the compiler. If
> some other u32 gets added in the future, user space will still see "88"
> as the size.
> 
> So I *think* the right change here is:
> 
> -};
> +	__u32 tgid;
> +} __packed;
> 
> Though tgid may need to go above seccomp_data... for when it grows.
> Agh...
> 
> _However_, unfortunately, I appear to have no thought this through very
> well, and there is actually no sanity-checking in the kernel for dealing
> with an old userspace when sizes change. :( For example, if a userspace
> doesn't check sizes and calls an ioctl, etc, the kernel will clobber the
> user buffer if it's too small.

I'd just argue that that's just userspace messing up.

> 
> Even the SECCOMP_GET_NOTIF_SIZES command lacks a buffer size argument.
> :(
> 
> So:
> 
> - should we just declare such userspace as "wrong"? I don't think
>   that'll work, especially since what if we ever change the size of
>   seccomp_data...  that predated the ..._SIZES command.

Yeah, that's nasty since the struct member in seccomp_notif would now
clobber each other.

> 
> - should we add a SECCOMP_SET_SIZES command to tell the kernel what
>   we're expecting? There's no "state" associated across seccomp(2)
>   calls, but maybe that doesn't matter because only user_notif writes
>   back to userspace. For the ioctl, the state could be part of the
>   private file data? Sending seccomp_data back to userspace only
>   happens here, and any changes in seccomp_data size will just be seen
>   as allowing a filter to query further into it.

Sounds ok-ish in my opinion.

> 
> - should GET_SIZES report "useful" size? (i.e. exclude padding?)

Or... And that's more invasive but ultimately cleaner we v2 the whole
thing so e.g. SECCOMP_IOCTL_NOTIF_RECV2, SECCOMP_IOCTL_NOTIF_SEND2, and
embedd the size argument in the structs. Userspace sets the size
argument, we use get_user() to get the size first and then
copy_struct_from_user() to handle it cleanly based on that. A similar
model as with sched (has other unrelated quirks because they messed up
something too):

static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *attr)
{
	u32 size;
	int ret;

	/* Zero the full structure, so that a short copy will be nice: */
	memset(attr, 0, sizeof(*attr));

	ret = get_user(size, &uattr->size);
	if (ret)
		return ret;

	/* ABI compatibility quirk: */
	if (!size)
		size = SCHED_ATTR_SIZE_VER0;
	if (size < SCHED_ATTR_SIZE_VER0 || size > PAGE_SIZE)
		goto err_size;

	ret = copy_struct_from_user(attr, sizeof(*attr), uattr, size);
	if (ret) {
		if (ret == -E2BIG)
			goto err_size;
		return ret;
	}

We're probably the biggest user of this right now and I'd be ok with
that change. If it's a v2 than whatever. :)

Christian
