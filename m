Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B72CABB28B
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2019 13:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbfIWLA6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Mon, 23 Sep 2019 07:00:58 -0400
Received: from mailout.enyo.de ([116.203.30.208]:47613 "EHLO mailout.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbfIWLA6 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 23 Sep 2019 07:00:58 -0400
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Sep 2019 07:00:57 EDT
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iCLxt-0007C5-AJ; Mon, 23 Sep 2019 10:53:09 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1iCLxt-0001IF-7K; Mon, 23 Sep 2019 12:53:09 +0200
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
Date:   Mon, 23 Sep 2019 12:53:09 +0200
In-Reply-To: <90399dee-53d8-a82c-3871-9ec8f94601ce@gmail.com> (Michael
        Kerrisk's message of "Mon, 23 Sep 2019 11:11:53 +0200")
Message-ID: <87tv939td6.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Michael Kerrisk:

> SYNOPSIS
>        int pidfd_open(pid_t pid, unsigned int flags);

Should this mention <sys/types.h> for pid_t?

> ERRORS
>        EINVAL flags is not 0.
>
>        EINVAL pid is not valid.
>
>        ESRCH  The process specified by pid does not exist.

Presumably, EMFILE and ENFILE are also possible errors, and so is
ENOMEM.

>        A  PID  file descriptor can be monitored using poll(2), select(2),
>        and epoll(7).  When the process that it refers to terminates,  the
>        file descriptor indicates as readable.  Note, however, that in the
>        current implementation, nothing can be read from the file descrip‐
>        tor.

“is indicated as readable” or “becomes readable”?  Will reading block?

>        The  pidfd_open()  system call is the preferred way of obtaining a
>        PID file descriptor.  The alternative is to obtain a file descrip‐
>        tor by opening a /proc/[pid] directory.  However, the latter tech‐
>        nique is possible only if the proc(5) file system is mounted; fur‐
>        thermore,  the  file  descriptor  obtained in this way is not pol‐
>        lable.

One question is whether the glibc wrapper should fall back back to the
/proc subdirectory if it is not available.  Probably not.

>        static
>        int pidfd_open(pid_t pid, unsigned int flags)
>        {
>            return syscall(__NR_pidfd_open, pid, flags);
>        }

Please call this function something else (not pidfd_open), so that the
example continues to work if glibc provides the system call wrapper.
