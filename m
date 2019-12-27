Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5583112B51C
	for <lists+linux-api@lfdr.de>; Fri, 27 Dec 2019 15:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfL0OW6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 27 Dec 2019 09:22:58 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32972 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfL0OW6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 27 Dec 2019 09:22:58 -0500
Received: by mail-ed1-f67.google.com with SMTP id r21so25369051edq.0
        for <linux-api@vger.kernel.org>; Fri, 27 Dec 2019 06:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JEcPiC990UIu1o6Rm9PyiqAOwz2kqcjhohkdZ3BkGrk=;
        b=2RpH0Vy1AMF+AI8iyUxD4dx1Wfjzzt9+heTxoJQiSWCsh+nWDkpHXS19CMdvBy8MOa
         f0/HRfO6cjojWhRfyhAeEFSgmjtmq+GSlpG3SoknjPL+asmIhx06eNsB04KXOBsYmCAc
         8Bye4WGZaPnikvaFZkFub9VU918ps2Bgff4Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JEcPiC990UIu1o6Rm9PyiqAOwz2kqcjhohkdZ3BkGrk=;
        b=RbHcPo34aGek3pCMWtkyNv3Mn+vB6vfzA/idZcT44DCbFYck3c2MLhJwulfdMi+cbK
         mipZkR+JoKZSLOWjEpV17jABO4UEUsyoh+YQxHRWigU2HA/DW4NzA0peclK1ZDRUfdM/
         N0JZ9kjRWRvXWHQqN3XKkOJ8KvvwT0CCZl0jU36JHf1htuCNZHU0XSKGvhFiFOHmgG1y
         3yY8emlNh8wxMGYQOLJ7veezXqKB8wUjvap9oyJmAqwysKrAh0+m9HFtrk6K+QOQYMdP
         atfEIBZFhpvLnMIJBpw270I4bUfUKKk6tRKMCKyhHu+8w8ZuQRwMEkYmDV4TwRFqbl5N
         RA7Q==
X-Gm-Message-State: APjAAAUH4c4wx9cpiVwhvyLZkpIzVgjuU0S8dZSEe5f8Kb/AhzEhgYS9
        /TgobkyGNHpchonRV86QQxpzK2jHxP1Rn8889hqJAA==
X-Google-Smtp-Source: APXvYqx2tuUgjQso4YnhzbwPiaAJm/PajDbvc5huQlv9PhCuh6VkBQXTYfTYhLY9VzvG+nQCHwBxdBrmdc9dfG8P26k=
X-Received: by 2002:a17:906:22cf:: with SMTP id q15mr52907186eja.77.1577456576199;
 Fri, 27 Dec 2019 06:22:56 -0800 (PST)
MIME-Version: 1.0
References: <20191225214530.GA27780@ircssh-2.c.rugged-nimbus-611.internal>
 <20191226115245.usf7z5dkui7ndp4w@wittgenstein> <20191226143229.sbopynwut2hhsiwn@yavin.dot.cyphar.com>
 <57C06925-0CC6-4251-AD57-8FF1BC28F049@ubuntu.com> <20191227022446.37e64ag4uaqms2w4@yavin.dot.cyphar.com>
 <20191227023131.klnobtlfgeqcmvbb@yavin.dot.cyphar.com> <20191227114725.xsacnaoaaxdv6yg3@wittgenstein>
In-Reply-To: <20191227114725.xsacnaoaaxdv6yg3@wittgenstein>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Fri, 27 Dec 2019 09:22:20 -0500
Message-ID: <CAMp4zn8iMsRvDoDtrotfnEm2_UUULH9VRiR6q9u8CS4qham2Eg@mail.gmail.com>
Subject: Re: [PATCH] seccomp: Check flags on seccomp_notif is unset
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Dec 27, 2019 at 6:47 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Fri, Dec 27, 2019 at 01:31:31PM +1100, Aleksa Sarai wrote:
> > On 2019-12-27, Aleksa Sarai <cyphar@cyphar.com> wrote:
> >
> > Scratch that -- as Tycho just mentioned, there is un-named padding in
> > the struct so check_zeroed_user() is the wrong thing to do. But this
>
> Hm, I don't think so.
> I understood Tycho's point as _if_ there ever is padding then this would
> not be zeroed.
> Right now, there is no padding since the struct is correctly padded:
>
> struct seccomp_data {
>         int nr;
>         __u32 arch;
>         __u64 instruction_pointer;
>         __u64 args[6];
> };
>
> struct seccomp_notif {
>         __u64 id;
>         __u32 pid;
>         __u32 flags;
>         struct seccomp_data data;
> };
>
> which would be - using pahole:
>
> struct seccomp_data {
>         int                        nr;                   /*     0     4 */
>         __u32                      arch;                 /*     4     4 */
>         __u64                      instruction_pointer;  /*     8     8 */
>         __u64                      args[6];              /*    16    48 */
>
>         /* size: 64, cachelines: 1, members: 4 */
> };
> struct seccomp_notif {
>         __u64                      id;                   /*     0     8 */
>         __u32                      pid;                  /*     8     4 */
>         __u32                      flags;                /*    12     4 */
>         struct seccomp_data data;                        /*    16    64 */
>
>         /* size: 80, cachelines: 2, members: 4 */
>         /* last cacheline: 16 bytes */
> };
>
> The only worry would be a 2byte int type but there's no architecture
> we support which does this right now afaict.
>
> > also will make extensions harder to deal with because (presumably) they
> > will also have un-named padding, making copy_struct_from_user() the
>
> This all will be a non-issue if we just use __u64 for extensions.
>
> My point about using copy_struct_from_user() was that we should verify
> that _all_ fields are uninitialized and not just the flags argument
> since we might introduce a flags argument that requires another already
> existing member in seccomp_notif to be set to a value. We should do this
> change now so we don't have to risk breaking someone in the future.
>
> I'm trying to get at least Mozilla/Firefox off of their crazy
> SECCOMP_RET_TRAP way of implementing their broker onto the user notifier
> and they will likely need some extensions. That includes the pidfd stuff
> for seccomp that Sargun will likely be doing and the new pidfd_getfd()
> syscall. So it's not unlikely that we might need other already existing
> fields in that struct to be set to some value.
>
> I don't particulary care how we do it:
> - We can do a simple copy_from_user() and check each field individually.
Just doing a simple copy_from_user, and for now, calling memchr_inv
on the whole thing. We can drop the memset, and just leave a note to
indicate that if unpadded fields are introduced in the future, this structure
must be manually zeroed out. Although, this might be laying a trap for
ourselves.

This leaves us in a good position for introducing a flag field in the future.
All we have to do is change the memchr_inv from checking on an
entire struct basis to checking on a per-field basis.

> - Use copy_struct_from_user().
>   That is safe to do right now since there is no padding afaict and
>   it'll automatically verify new fields as well.
>   If I understand the worry correctly then the argument against
>   copy_struct_from_user() here is that there might be padding introduced
>   and userspace will not do an explicit memset() but rather rely on an
>   empty inializer {} and will _accidently_ pass down a struct which has
>   __all fields cleared__ but __uninitialized padding__ and we tell them
>   EINVAL? That can only happen if we introduce padding in the struct
>   which I'd argue we just don't do. That'll be in line with what we
>   require from our ABIs already anyway.
>
> Christian
