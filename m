Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4241D8A15
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2020 23:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgERVhi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 May 2020 17:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbgERVhi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 18 May 2020 17:37:38 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226D3C061A0C
        for <linux-api@vger.kernel.org>; Mon, 18 May 2020 14:37:38 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id t15so5502443ios.4
        for <linux-api@vger.kernel.org>; Mon, 18 May 2020 14:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PS//4W49LeX9Vs+lxZu9gg7QYyqRhCBlBHWbz6v23bo=;
        b=cKR3pqRH2lLjEXlXFaO+eDoDtdxmLA25ueQY7ECKTbG7903OEMmVNkwirdBQ7LuA3k
         wz3sZoA1MUXbfGSSc+bE9n1lP1+2AyTFD/8VaZLl0VlHcUy0sBfH7flEfcHbqgsUQ9fN
         xOjGNn0KvmYzQ3yvdruPt2KQlPsQfk8cR0kjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PS//4W49LeX9Vs+lxZu9gg7QYyqRhCBlBHWbz6v23bo=;
        b=Nbit9n+3Tcy5q0yX5LhyVVp6WSvnlKwaMmap9Cn/q41UaXZM74pPVtw+Z77AeHM+sT
         8yJ34fFkLWeYcKWZh5JTWlVl16D2ytGcSu9Hfaz8BK6/WhDaFUDOipmXKwT6p436wkaq
         uMz3sE1smzZZRKefcfQ4lH5lpwvRXY8/P7+pJD8REHTyru14SQAJAFE8EFs+x2zohMnO
         l+WHjQ/0gf3h+KArx1GOnU5MHDHJWVd+dxZy/Ssfy+BAiKNA1mQTjKzjX07VeHSya0i6
         hth5ULXyqCsHgfzh/5eDirxMNGe7g84pKJFnkuOi3GWmDFSgEC1Bzr8APnhs7QhDyhYQ
         sNrQ==
X-Gm-Message-State: AOAM533QFI/H2oJT0iRhD3gkUjnii5cKOxhKcsYbGHm/veBghPJZRz30
        lmVXuXJUZbijEDHvfnVigg4ytw==
X-Google-Smtp-Source: ABdhPJwNC6ZrM01bUDFpeSIEpLw5mCNXAO6WtOX6hiP1ExKQ7BInjPiC+zdoq09ow1N0BwBUpdtlvA==
X-Received: by 2002:a5d:94c5:: with SMTP id y5mr4097703ior.43.1589837857147;
        Mon, 18 May 2020 14:37:37 -0700 (PDT)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id f10sm5235937ilj.85.2020.05.18.14.37.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 May 2020 14:37:36 -0700 (PDT)
Date:   Mon, 18 May 2020 21:37:35 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Tycho Andersen <tycho@tycho.ws>, Aleksa Sarai <asarai@suse.de>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seccomp: Add group_leader pid to seccomp_notif
Message-ID: <20200518213734.GA25216@ircssh-2.c.rugged-nimbus-611.internal>
References: <20200515234005.32370-1-sargun@sargun.me>
 <202005162344.74A02C2D@keescook>
 <20200517104701.bbn2d2rqaplwchdw@wittgenstein>
 <20200517112156.cphs2h33hx2wfcs4@yavin.dot.cyphar.com>
 <20200517142316.GA1996744@cisco>
 <20200517143311.fmxaf3pnopuaezl4@wittgenstein>
 <20200517144603.GD1996744@cisco>
 <20200517150215.GE1996744@cisco>
 <20200518125325.l2lpixp3ch7zuiwx@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518125325.l2lpixp3ch7zuiwx@wittgenstein>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 18, 2020 at 02:53:25PM +0200, Christian Brauner wrote:
> On Sun, May 17, 2020 at 09:02:15AM -0600, Tycho Andersen wrote:
> > On Sun, May 17, 2020 at 08:46:03AM -0600, Tycho Andersen wrote:
> > > On Sun, May 17, 2020 at 04:33:11PM +0200, Christian Brauner wrote:
> > > > struct seccomp_notif2 {
> > > > 	__u32 notif_size;
> > > > 	__u64 id;
> > > > 	__u32 pid;
> > > > 	__u32 flags;
> > > > 	struct seccomp_data data;
> > > > 	__u32 data_size;
> > > > };
> > > 
> > > I guess you need to put data_size before data, otherwise old userspace
> > > with a smaller struct seccomp_data will look in the wrong place.
> > > 
> > > But yes, that'll work if you put two sizes in, which is probably
> > > reasonable since we're talking about two structs.
> > 
> > Well, no, it doesn't either. Suppose we add a new field first to
> > struct seccomp_notif2:
> > 
> > struct seccomp_notif2 {
> >     __u32 notif_size;
> >     __u64 id;
> >     __u32 pid;
> >     __u32 flags;
> >     struct seccomp_data data;
> >     __u32 data_size;
> >     __u32 new_field;
> > };
> > 
> > And next we add a new field to struct secccomp_data. When a userspace
> > compiled with just the new seccomp_notif2 field does:
> > 
> > seccomp_notif2.new_field = ...;
> > 
> > the compiler will put it in the wrong place for the kernel with the
> > new seccomp_data field too.
> > 
> > Sort of feels like we should do:
> > 
> > struct seccomp_notif2 {
> >     struct seccomp_notif *notif;
> >     struct seccomp_data *data;
> > };
> > 
> > ?
> 
> Oh yes of course, sorry that was my stupid typo. I meant:
> 
> struct seccomp_notif2 {
>     __u32 notif_size;
>     __u64 id;
>     __u32 pid;
>     __u32 flags;
>     struct seccomp_data *data;
>     __u32 data_size;
>     __u32 new_field;
> }
One big difference in the approach I described is that the user gets to ask
for specific fields, and can configure the listener upfront, versus having to
do the dance of fetching the sizes, and dynamically allocating memory.

This way userspace can just do on-stack static allocations. We can get
rid of the kbuf bits in my PR, if we incrementally fill up the userspace buffer
(copy_to_user shouldn't be *that* costly).

In addition, we're not copying a bunch of unnecessary data, or calculating
values that the user may not be interested in. This is particularly valuable
if we ever want to do things like passing optional fields (think PIDs) back.

Code-wise, it looks something like:
struct read_output_format {
	__u64 id;
	__u32 tgid;
	struct seccomp_data data;
} __packed;

TEST(user_notification_read)
{
	long ret;
	int status, pid, listener, read_size;
	struct seccomp_notif_config config = {};
	struct seccomp_notif_resp resp = {};
	struct read_output_format buf;

	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
	ASSERT_EQ(0, ret) {
		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
	}

	listener = user_trap_syscall(__NR_dup, SECCOMP_FILTER_FLAG_NEW_LISTENER);
	ASSERT_GE(listener, 0);

	EXPECT_EQ(read(listener, &buf, sizeof(buf)), -1) {
		EXPECT_EQ(errno, -EINVAL);
	}

	config.size = sizeof(config);
	config.seccomp_data_size = sizeof(struct seccomp_data);
	config.optional_fields = ~(0);
	/* Make sure invalid fields are not accepted */
	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_CONFIG, &config), -1);

	config.optional_fields = SECCOMP_NOTIF_FIELD_TGID;
	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_CONFIG, &config), sizeof(buf));

	pid = fork();
	ASSERT_GE(pid, 0);
	if (pid == 0)
		exit(syscall(__NR_dup, 42, 1, 1, 1) != USER_NOTIF_MAGIC);


	/* Passing a smaller value in should fail */
	EXPECT_EQ(read(listener, &buf, read_size - 1), -1) {
		EXPECT_EQ(errno, -E2BIG);
	}
	/* Passing a larger value in should succeed */
	ASSERT_EQ(read(listener, &buf, 200), sizeof(buf));
	EXPECT_EQ(buf.tgid, pid);
	EXPECT_EQ(buf.data.args[0], 42);
	EXPECT_EQ(buf.data.nr, __NR_dup);

	resp.id = buf.id;
	resp.error = 0;
	resp.val = USER_NOTIF_MAGIC;

	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);

	EXPECT_EQ(waitpid(pid, &status, 0), pid);
	EXPECT_EQ(true, WIFEXITED(status));
	EXPECT_EQ(0, WEXITSTATUS(status));
}

> 
> at which point things should just work imho. This is similar to how the
> set_tid array works. The kernel doesn't need to allocate any more too.
> The kernel can just always use the currently know seccomp_data size.
> If the kernel supports _less_ than what the caller expects, it can
> report the supported size in data_size to userspace returning EINVAL. If
> it supports more then it can just copy the known fields, I guess.
> 
> This way we don't need to add yet another ioctl...
> 
> Christian
