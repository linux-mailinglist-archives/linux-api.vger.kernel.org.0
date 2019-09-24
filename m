Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 080C5BD2F1
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2019 21:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441944AbfIXTnm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Sep 2019 15:43:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45810 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395538AbfIXTnl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Sep 2019 15:43:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id r5so3325772wrm.12;
        Tue, 24 Sep 2019 12:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZbmGKH+DoD4e4TU0rL8OW+6yE02iYsouUxhdX3yNhV4=;
        b=H2na7SsLZPHFIjyCac4VcZKwCIpZqZVH2iS/v/KPU8+8vkqmJrKqIvu+Byy+18gdUT
         NzBcCfIVBI6yCWllrdlzRBTYNTC3iowJqlgXq8NnuKXf70/LtUzSGwEa4/Ar4OgwZiHI
         bZexQkHLUTmS7DEjx+ECMjebf4dUSAyx5kQXmvj8DYV3VU7BOnrlJr7Hc6ZhCKFkZDLG
         ub4cB1NYcg33EARdvgGpy2LyAJ7NI4beSn7LsqN+qOlUSLrARkS6Hm4FeNFiBjeHUTPr
         Itl7mYxel0f3CcDzpMIcxMZTGE3LWrlvdO/H9U7DqP8CT2YxqRVHdWqWbP1cFEd7JbZ4
         98rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZbmGKH+DoD4e4TU0rL8OW+6yE02iYsouUxhdX3yNhV4=;
        b=eKD0hcGTcLMme+8iCIralVeSy2LfqLiS8LcrTylxwB0sc+ySnOyQNFfxOlpdJ1i01g
         RmCpc24oCGKGzlsL1uG8SCv9uyZ6lzXscpITEKYlD7JLguFPbWFzZdk1GHkZZuglXk5Y
         zgpFVcsxEG9ChBGeufflslF0Yrw+FIe1wKu1tvggeDZxWQORHKHtZ0CajdDxAVxo7feu
         ntjvB3y2zyFMWMqgCJlbrxAIVS/PfBeEcSJRxEdb8ziBqJx4lT+C9Wv0dNODE1spRwW3
         uza50Pm63zq05vZG5a1cFVVM5haZB2hFY6ntbn6YF2GBYlttgyZAZ3Xoq8HbB4UmTBRD
         rYoQ==
X-Gm-Message-State: APjAAAWrDCtD047aD+i6qMnIUU7cdrsSMM2uoXk6nxZehqFOyAwGulBB
        WSkDppXnKowoPthq/QwT7dfciDp8
X-Google-Smtp-Source: APXvYqzMXr8MC+in2pAg7SeE0IHESj9+qAK00yGFjlDifW6en5O3NMyy3TIpj55bCizARJqErphLsg==
X-Received: by 2002:adf:ef0c:: with SMTP id e12mr2003774wro.81.1569354219435;
        Tue, 24 Sep 2019 12:43:39 -0700 (PDT)
Received: from ?IPv6:2001:a61:24d6:4e01:ef75:e978:47cd:1c50? ([2001:a61:24d6:4e01:ef75:e978:47cd:1c50])
        by smtp.gmail.com with ESMTPSA id q10sm5746592wrd.39.2019.09.24.12.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 12:43:38 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: For review: pidfd_send_signal(2) manual page
To:     Florian Weimer <fw@deneb.enyo.de>
References: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com>
 <87pnjr9rth.fsf@mid.deneb.enyo.de>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <f4330496-f34e-59f2-6de4-0aafdf639c7a@gmail.com>
Date:   Tue, 24 Sep 2019 21:43:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87pnjr9rth.fsf@mid.deneb.enyo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Florian,

On 9/23/19 1:26 PM, Florian Weimer wrote:
> * Michael Kerrisk:
> 
>> SYNOPSIS
>>        int pidfd_send_signal(int pidfd, int sig, siginfo_t info,
>>                              unsigned int flags);
> 
> This probably should reference a header for siginfo_t.

Thanks. I added: #include <signal.h>

>>        ESRCH  The target process does not exist.
> 
> If the descriptor is valid, does this mean the process has been waited
> for?  Maybe this can be made more explicit.

Yes. I added "(i.e., it has terminated and been waited on)".

>>        The  pidfd_send_signal()  system call allows the avoidance of race
>>        conditions that occur when using traditional interfaces  (such  as
>>        kill(2)) to signal a process.  The problem is that the traditional
>>        interfaces specify the target process via a process ID (PID), with
>>        the  result  that the sender may accidentally send a signal to the
>>        wrong process if the originally intended target process has termi‐
>>        nated  and its PID has been recycled for another process.  By con‐
>>        trast, a PID file descriptor is a stable reference to  a  specific
>>        process;  if  that  process  terminates,  then the file descriptor
>>        ceases to be  valid  and  the  caller  of  pidfd_send_signal()  is
>>        informed of this fact via an ESRCH error.
> 
> It would be nice to explain somewhere how you can avoid the race using
> a PID descriptor.  Is there anything else besides CLONE_PIDFD?

Please see my comment in reply to Christian (which will be sent just
after this).

>>        static
>>        int pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
>>                unsigned int flags)
>>        {
>>            return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
>>        }
> 
> Please use a different function name.  Thanks.

Please see my open question in the thread on pidfd_open().

Thanks for the review, Florian.

Cheers,

Michael

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
