Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0A3E12CB5F
	for <lists+linux-api@lfdr.de>; Mon, 30 Dec 2019 00:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfL2Xm4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 29 Dec 2019 18:42:56 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45698 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfL2Xmz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 29 Dec 2019 18:42:55 -0500
Received: by mail-ed1-f65.google.com with SMTP id v28so31239373edw.12
        for <linux-api@vger.kernel.org>; Sun, 29 Dec 2019 15:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rabM4rIBG0N1M+zRAZDgiIgam+NL7i76tMVOocyysIA=;
        b=i9I+1XWGtwozpDStyAtdXl2Y7rNL91aJQKe89LIOv8m95Q5kRD2kQDspkJNDITpuFe
         1MD5U4rwgnUrTU402OYsrVzhxr2gC7yPjPdPIGegjEkjGDLpOGHoTbC8ZMK7Z3A5UGfm
         WOB9uXPQTYVgwqZyyzKnm4s4aK8yaIxLIjSoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rabM4rIBG0N1M+zRAZDgiIgam+NL7i76tMVOocyysIA=;
        b=URVAtfNCXGG3w2L20TRzZjssQOhmdpK6NUZFvWx+AQfNbk++U8BokzmkgU7f/tuHuV
         bA/16RqbEMXmp8ucOwfWDCm9zEQQYso1Bi4SOJl+B1nnoxjf2P0cM1xkx5d6nbq4AmZg
         tj77iwNszfd+jWudU7wE3z6Vj8eBK1aA8g8DsB/68bdlFZOoesRGU4r+BRCACIkh3ii1
         rbxJOXB2B2Cll6O1TmJNMoVMgGE06sah5L2z2EaeON+J3b6h3FyFnPmeivNMmK9pwh5u
         cIQ5whruVVH2R4UGs+hfGqtDnnyh32W3tziaJOa+k66jpl7vcreYFN5eN6ZB7Yc84tcs
         a+Cw==
X-Gm-Message-State: APjAAAUQa6v8f4vfILduDanT8GvHZneKkTFT76hwTrmcDVHGvBl2BEtJ
        sqv78zFg1waKl57zUpGXFlzhupJ3jYaCEE5Uzl8e8A==
X-Google-Smtp-Source: APXvYqzK+Cf1LC8KJmdZ4Ymm0sJLKxzndri+nzBDJERNOOKphUkeQ16eB6yOCOEWGAmLIZHYZJc1evanGKmlwVjXu1Q=
X-Received: by 2002:a17:907:398:: with SMTP id ss24mr65192875ejb.317.1577662973730;
 Sun, 29 Dec 2019 15:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20191229062451.9467-1-sargun@sargun.me> <20191229062451.9467-3-sargun@sargun.me>
 <20191229171441.fxif7q32mv2hl3y4@wittgenstein> <CAMp4zn_4dN+5U2RxkpYp+m4=X9w2Wef1TuLZ2hRW+g+nK1cXGA@mail.gmail.com>
 <20191229194318.ogsqw5pbjppbtsf7@wittgenstein>
In-Reply-To: <20191229194318.ogsqw5pbjppbtsf7@wittgenstein>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Sun, 29 Dec 2019 15:42:17 -0800
Message-ID: <CAMp4zn_39bsyZo6BeZ6b+c_EeAHdWmqcJus6qD2xYp84cEcZaA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selftests/seccomp: Test kernel catches garbage on SECCOMP_IOCTL_NOTIF_RECV
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Tycho Andersen <tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Dec 29, 2019 at 11:43 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Sun, Dec 29, 2019 at 11:06:25AM -0800, Sargun Dhillon wrote:
> > On Sun, Dec 29, 2019 at 12:14 PM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > > Does that even work if no dup() syscall has been made and trapped?
> > Yes, the first check that occurs is the check which checks if
> > seccom_notif has been
> > zeroed out. This happens before any of the other work.
>
> Ah, then sure I don't mind doing it this way. Though plumbing it
> directly into TEST(user_notification_basic) like I did below seems
> cleaner to me.
>
> >
> > > This looks like it would give you ENOENT...
> > This ioctl is a blocking ioctl. It'll block until there is a wakeup.
> > In this case, the wakeup
> > will never come, but that doesn't mean we get an ENOENT.
>
> Yeah, but that wold mean the test will hang weirdly if it bypasses the
> check. Sure it'll timeout but meh. I think I would prefer to have this
> done as part of the basic test where we know that there is an event but
> _shrug_.
>
> Christian

My one worry about this is that the behaviour should be if the input
(seccomp_notif) is invalid, it should immediately bail out, whether
or not there is an event waiting. If we add it to basic_test, then
it would hide the erroneous behaviour if bailout isn't immediate.

I'm not sure if that's a worry or not.
