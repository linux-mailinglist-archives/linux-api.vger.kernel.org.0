Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3DB4BB2C6
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2019 13:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393796AbfIWL0r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Mon, 23 Sep 2019 07:26:47 -0400
Received: from mailout.enyo.de ([116.203.30.208]:38369 "EHLO mailout.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393655AbfIWL0r (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 23 Sep 2019 07:26:47 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iCMUF-0008D5-19; Mon, 23 Sep 2019 11:26:35 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1iCMUE-0001j8-TI; Mon, 23 Sep 2019 13:26:34 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: For review: pidfd_send_signal(2) manual page
References: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com>
Date:   Mon, 23 Sep 2019 13:26:34 +0200
In-Reply-To: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com> (Michael
        Kerrisk's message of "Mon, 23 Sep 2019 11:12:00 +0200")
Message-ID: <87pnjr9rth.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Michael Kerrisk:

> SYNOPSIS
>        int pidfd_send_signal(int pidfd, int sig, siginfo_t info,
>                              unsigned int flags);

This probably should reference a header for siginfo_t.

>        ESRCH  The target process does not exist.

If the descriptor is valid, does this mean the process has been waited
for?  Maybe this can be made more explicit.

>        The  pidfd_send_signal()  system call allows the avoidance of race
>        conditions that occur when using traditional interfaces  (such  as
>        kill(2)) to signal a process.  The problem is that the traditional
>        interfaces specify the target process via a process ID (PID), with
>        the  result  that the sender may accidentally send a signal to the
>        wrong process if the originally intended target process has termi‐
>        nated  and its PID has been recycled for another process.  By con‐
>        trast, a PID file descriptor is a stable reference to  a  specific
>        process;  if  that  process  terminates,  then the file descriptor
>        ceases to be  valid  and  the  caller  of  pidfd_send_signal()  is
>        informed of this fact via an ESRCH error.

It would be nice to explain somewhere how you can avoid the race using
a PID descriptor.  Is there anything else besides CLONE_PIDFD?

>        static
>        int pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
>                unsigned int flags)
>        {
>            return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
>        }

Please use a different function name.  Thanks.
