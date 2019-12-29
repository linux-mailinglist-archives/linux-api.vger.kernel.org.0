Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86F4A12CAAE
	for <lists+linux-api@lfdr.de>; Sun, 29 Dec 2019 20:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfL2Tna (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 29 Dec 2019 14:43:30 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37936 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfL2Tna (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 29 Dec 2019 14:43:30 -0500
Received: from [172.58.107.62] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ileTH-0006MP-Pg; Sun, 29 Dec 2019 19:43:28 +0000
Date:   Sun, 29 Dec 2019 20:43:20 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH v3 3/3] selftests/seccomp: Test kernel catches garbage on
 SECCOMP_IOCTL_NOTIF_RECV
Message-ID: <20191229194318.ogsqw5pbjppbtsf7@wittgenstein>
References: <20191229062451.9467-1-sargun@sargun.me>
 <20191229062451.9467-3-sargun@sargun.me>
 <20191229171441.fxif7q32mv2hl3y4@wittgenstein>
 <CAMp4zn_4dN+5U2RxkpYp+m4=X9w2Wef1TuLZ2hRW+g+nK1cXGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMp4zn_4dN+5U2RxkpYp+m4=X9w2Wef1TuLZ2hRW+g+nK1cXGA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Dec 29, 2019 at 11:06:25AM -0800, Sargun Dhillon wrote:
> On Sun, Dec 29, 2019 at 12:14 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Sat, Dec 28, 2019 at 10:24:51PM -0800, Sargun Dhillon wrote:
> > > Add a self-test to make sure that the kernel returns EINVAL, if any
> > > of the fields in seccomp_notif are set to non-null.
> > >
> > > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > > Suggested-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > ---
> > >  tools/testing/selftests/seccomp/seccomp_bpf.c | 23 +++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> > > index f53f14971bff..379391a7fa41 100644
> > > --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> > > +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> > > @@ -3601,6 +3601,29 @@ TEST(user_notification_continue)
> > >       }
> > >  }
> > >
> > > +TEST(user_notification_garbage)
> > > +{
> > > +     /*
> > > +      * intentionally set pid to a garbage value to make sure the kernel
> > > +      * catches it
> > > +      */
> > > +     struct seccomp_notif req = {
> > > +             .pid    = 1,
> > > +     };
> > > +     int ret, listener;
> > > +
> > > +     ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> > > +     ASSERT_EQ(0, ret) {
> > > +             TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
> > > +     }
> > > +
> > > +     listener = user_trap_syscall(__NR_dup, SECCOMP_FILTER_FLAG_NEW_LISTENER);
> > > +     ASSERT_GE(listener, 0);
> > > +
> > > +     EXPECT_EQ(-1, ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req));
> > > +     EXPECT_EQ(EINVAL, errno);
> >
> > Does that even work if no dup() syscall has been made and trapped?
> Yes, the first check that occurs is the check which checks if
> seccom_notif has been
> zeroed out. This happens before any of the other work.

Ah, then sure I don't mind doing it this way. Though plumbing it
directly into TEST(user_notification_basic) like I did below seems
cleaner to me.

> 
> > This looks like it would give you ENOENT...
> This ioctl is a blocking ioctl. It'll block until there is a wakeup.
> In this case, the wakeup
> will never come, but that doesn't mean we get an ENOENT.

Yeah, but that wold mean the test will hang weirdly if it bypasses the
check. Sure it'll timeout but meh. I think I would prefer to have this
done as part of the basic test where we know that there is an event but
_shrug_.

Christian
