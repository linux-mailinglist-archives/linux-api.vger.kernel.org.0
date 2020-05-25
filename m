Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4E51E0433
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2020 02:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388479AbgEYAjZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 24 May 2020 20:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388014AbgEYAjZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 24 May 2020 20:39:25 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B748C061A0E;
        Sun, 24 May 2020 17:39:25 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jd19D-00EviN-Co; Mon, 25 May 2020 00:39:19 +0000
Date:   Mon, 25 May 2020 01:39:19 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Jann Horn <jannh@google.com>, Robert Sesek <rsesek@google.com>,
        Chris Palmer <palmer@google.com>,
        Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Subject: Re: [PATCH 2/5] seccomp: Introduce addfd ioctl to seccomp user
 notifier
Message-ID: <20200525003919.GC23230@ZenIV.linux.org.uk>
References: <20200524233942.8702-1-sargun@sargun.me>
 <20200524233942.8702-3-sargun@sargun.me>
 <20200525000537.GB23230@ZenIV.linux.org.uk>
 <CAMp4zn-F3b8Z4ZDjgnJM1Fbban2oVtCm_rZkhBhDKs6fw2_=rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMp4zn-F3b8Z4ZDjgnJM1Fbban2oVtCm_rZkhBhDKs6fw2_=rg@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, May 24, 2020 at 05:27:58PM -0700, Sargun Dhillon wrote:

> >         if (addfd->fd >= 0) {
> >                 ret = replace_fd(addfd->fd, addfd->file, addfd->flags);
> >         } else {
> >                 ret = get_unused_fd_flags(addfd->flags);
> >                 if (ret >= 0)
> >                         fd_install(ret, get_file(addfd->file));
					    ^^^^^^^^

> Wouldn't this result in consumption of reference in one case (fd_install),
> and the fd still having a reference in the replace_fd case?
