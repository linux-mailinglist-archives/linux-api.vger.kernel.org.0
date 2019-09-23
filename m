Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93291BBD38
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2019 22:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfIWUl2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Sep 2019 16:41:28 -0400
Received: from mailout.enyo.de ([116.203.30.208]:53403 "EHLO mailout.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729108AbfIWUl2 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 23 Sep 2019 16:41:28 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iCV95-0003Nu-IP; Mon, 23 Sep 2019 20:41:19 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1iCV95-0003Ew-DI; Mon, 23 Sep 2019 22:41:19 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Daniel Colascione <dancol@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: For review: pidfd_open(2) manual page
References: <90399dee-53d8-a82c-3871-9ec8f94601ce@gmail.com>
        <87tv939td6.fsf@mid.deneb.enyo.de>
        <63566f1f-667d-50ca-ae85-784924d09af4@gmail.com>
Date:   Mon, 23 Sep 2019 22:41:19 +0200
In-Reply-To: <63566f1f-667d-50ca-ae85-784924d09af4@gmail.com> (Michael
        Kerrisk's message of "Mon, 23 Sep 2019 22:20:31 +0200")
Message-ID: <874l12924w.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Michael Kerrisk:

>>>        static
>>>        int pidfd_open(pid_t pid, unsigned int flags)
>>>        {
>>>            return syscall(__NR_pidfd_open, pid, flags);
>>>        }
>> 
>> Please call this function something else (not pidfd_open), so that the
>> example continues to work if glibc provides the system call wrapper.
>
> I figured that if the syscall does get added to glibc, then I would
> modify the example. In the meantime, this does seem the most natural
> way of doing things, since the example then uses the real syscall
> name as it would be used if there were a wrapper function.

The problem is that programs do this as well, so they fail to build
once they are built on a newer glibc version.

> But, this leads to the question: what do you think the likelihood
> is that this system call will land in glibc?

Quite likely.  It's easy enough to document, there are no P&C issues,
and it doesn't need any new types.

pidfd_send_signal is slightly more difficult because we probably need
to add rt_sigqueueinfo first, for consistency.
