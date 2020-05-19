Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DE21D946C
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2020 12:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgESKfS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 19 May 2020 06:35:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41840 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgESKfS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 19 May 2020 06:35:18 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jazaa-0003Tv-Ci; Tue, 19 May 2020 10:35:12 +0000
Date:   Tue, 19 May 2020 12:35:11 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Sargun Dhillon <sargun@sargun.me>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: seccomp feature development
Message-ID: <20200519103511.2kbnpio5b3bcrvoo@wittgenstein>
References: <202005181120.971232B7B@keescook>
 <CAG48ez1LrQvR2RHD5-ZCEihL4YT1tVgoAJfGYo+M3QukumX=OQ@mail.gmail.com>
 <20200519024846.b6dr5cjojnuetuyb@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200519024846.b6dr5cjojnuetuyb@yavin.dot.cyphar.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 19, 2020 at 12:48:46PM +1000, Aleksa Sarai wrote:
> On 2020-05-19, Jann Horn <jannh@google.com> wrote:
> > On Mon, May 18, 2020 at 11:05 PM Kees Cook <keescook@chromium.org> wrote:
> > > ## deep argument inspection
> > >
> > > Background: seccomp users would like to write filters that traverse
> > > the user pointers passed into many syscalls, but seccomp can't do this
> > > dereference for a variety of reasons (mostly involving race conditions and
> > > rearchitecting the entire kernel syscall and copy_from_user() code flows).
> > 
> > Also, other than for syscall entry, it might be worth thinking about
> > whether we want to have a special hook into seccomp for io_uring.
> > io_uring is growing support for more and more syscalls, including
> > things like openat2, connect, sendmsg, splice and so on, and that list
> > is probably just going to grow in the future. If people start wanting
> > to use io_uring in software with seccomp filters, it might be
> > necessary to come up with some mechanism to prevent io_uring from
> > permitting access to almost everything else...
> > 
> > Probably not a big priority for now, but something to keep in mind for
> > the future.
> 
> Indeed. Quite a few people have raised concerns about io_uring and its
> debug-ability, but I agree that another less-commonly-mentioned concern
> should be how you restrict io_uring(2) from doing operations you've
> disallowed through seccomp. Though obviously user_notif shouldn't be
> allowed. :D

As soon as you switch kernels to an io_uring supported kernel while
maintaing a blacklist without updating all your seccomp filters you're
currently hosed (Yes, blacklists aren't great but they have their
uses.).

Christian
