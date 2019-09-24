Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D738BD2F6
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2019 21:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfIXTox (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Sep 2019 15:44:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53126 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfIXTox (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Sep 2019 15:44:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id r19so53991wmh.2;
        Tue, 24 Sep 2019 12:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Oche4Re2VFhM7eErBbJFcs7cnxJPKS0lIlpwuHdIbk8=;
        b=k58uhT/W2G0zHblbxUD4kY5mrQft0TJUBAgLY6xAy343d3H3WLg50eQd4hZ+K8PwKU
         wNnmVA6RF5OIFtj1neyU4fe9z/gUYuNmgel/CjA7lqb4msN0OhZ44rdxEQO6hvr4Gcih
         NmjBDACOFxweBVpyH53MA4kEexEFckn0jFKkEnh5+iFKfg0S6kAeVStamlMeFQ+cO8pA
         ThouNivtVc52vuFps6eH3bQUHwB1xDasgvNmxYfDmuCI5bc/Gauz9euydeISK7npILZZ
         e4FkdtMbbFwEOjBdnm6vSinyc6F6wZgAIgQJbZoLpiLuDZIFjrMjaJAn6+xfQph6Ezi2
         Ql1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Oche4Re2VFhM7eErBbJFcs7cnxJPKS0lIlpwuHdIbk8=;
        b=udN7lWBH1JWlpLTNYTNZQcTQeRgkveff3p8rg0EFid/oEcyeMoPaBiiT0Va5+eqanJ
         tMvk+ETFvlfdFfSEKIwSnf/6rXJjGIEyMKWQzBxDJ67r7n5uVD05idB+lW3S6jZHHiiO
         wnhXTJcDZ2cACCm9+UBj2G71iwzxuVzKH/1DRSGNY5gGrh9x/gDY4icT9xNtxBNEDfxA
         ya1AAyr519FaizxQlLQEaEx2YCpkRWd7wloQBpwOF46Vh42/LINAyFNOfLeL+wdsgXGE
         5oVn1itHdbH/imJOBmTkDjZdi3TT0lFS/SUyuYFTNiMYIH97lJJ87eV3/eOFTp+J+YpZ
         xsKQ==
X-Gm-Message-State: APjAAAWOH3j4LA7C6UN4huDvHrsU8+snnduK0JJ6kb+SP4Pb48ICmKuP
        XZr79pYnhlqYoWUUzW5mDMnNbCXO
X-Google-Smtp-Source: APXvYqya/OiFxLoCvmfvaO9+xHxdB8gKdEriLNQJOVpJjEWqfPMhiRLvi2bZOetuv3pkVD0HoN/qOg==
X-Received: by 2002:a1c:d188:: with SMTP id i130mr2099922wmg.101.1569354290536;
        Tue, 24 Sep 2019 12:44:50 -0700 (PDT)
Received: from ?IPv6:2001:a61:24d6:4e01:ef75:e978:47cd:1c50? ([2001:a61:24d6:4e01:ef75:e978:47cd:1c50])
        by smtp.gmail.com with ESMTPSA id q192sm1864605wme.23.2019.09.24.12.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 12:44:49 -0700 (PDT)
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
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>
References: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com>
 <87pnjr9rth.fsf@mid.deneb.enyo.de>
 <20190923142325.jowzbnwjw7g7si7j@wittgenstein>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <90dd38d5-34b3-b72f-8e5a-b51f944f22fb@gmail.com>
Date:   Tue, 24 Sep 2019 21:44:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190923142325.jowzbnwjw7g7si7j@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Christian,

On 9/23/19 4:23 PM, Christian Brauner wrote:
> On Mon, Sep 23, 2019 at 01:26:34PM +0200, Florian Weimer wrote:
>> * Michael Kerrisk:
>>
>>> SYNOPSIS
>>>        int pidfd_send_signal(int pidfd, int sig, siginfo_t info,
>>>                              unsigned int flags);
>>
>> This probably should reference a header for siginfo_t.
> 
> Agreed.
> 
>>
>>>        ESRCH  The target process does not exist.
>>
>> If the descriptor is valid, does this mean the process has been waited
>> for?  Maybe this can be made more explicit.
> 
> If by valid you mean "refers to a process/thread-group leader" aka is a
> pidfd then yes: Getting ESRCH means that the process has exited and has
> already been waited upon.
> If it had only exited but not waited upon aka is a zombie, then sending
> a signal will just work because that's currently how sending signals to
> zombies works, i.e. if you only send a signal and don't do any
> additional checks you won't notice a difference between a process being
> alive and a process being a zombie. The userspace visible behavior in
> terms of signaling them is identical.

(Thanks for the clarification. I added the text "(i.e., it has 
terminated and been waited on)" to the ESRCH error.)

>>>        The  pidfd_send_signal()  system call allows the avoidance of race
>>>        conditions that occur when using traditional interfaces  (such  as
>>>        kill(2)) to signal a process.  The problem is that the traditional
>>>        interfaces specify the target process via a process ID (PID), with
>>>        the  result  that the sender may accidentally send a signal to the
>>>        wrong process if the originally intended target process has termi‐
>>>        nated  and its PID has been recycled for another process.  By con‐
>>>        trast, a PID file descriptor is a stable reference to  a  specific
>>>        process;  if  that  process  terminates,  then the file descriptor
>>>        ceases to be  valid  and  the  caller  of  pidfd_send_signal()  is
>>>        informed of this fact via an ESRCH error.
>>
>> It would be nice to explain somewhere how you can avoid the race using
>> a PID descriptor.  Is there anything else besides CLONE_PIDFD?
> 
> If you're the parent of the process you can do this without CLONE_PIDFD:
> pid = fork();
> pidfd = pidfd_open();
> ret = pidfd_send_signal(pidfd, 0, NULL, 0);
> if (ret < 0 && errno == ESRCH)
> 	/* pidfd refers to another, recycled process */

Although there is still the race between the fork() and the
pidfd_open(), right?

>>>        static
>>>        int pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
>>>                unsigned int flags)
>>>        {
>>>            return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
>>>        }
>>
>> Please use a different function name.  Thanks.

Covered in another thread. I await some further feedback from Florian.

Thanks,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
