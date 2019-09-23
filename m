Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD6B7BBCB4
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2019 22:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502518AbfIWUUg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Sep 2019 16:20:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40531 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbfIWUUg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 23 Sep 2019 16:20:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id b24so10644849wmj.5;
        Mon, 23 Sep 2019 13:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YMzh6ohccmoq8aH/L2hJKrm4rl1SlByXPnUDhSvoKrM=;
        b=kRGGE4xpmb43uE/+VQCLOyeUG4I3hqzJeFpMbyEjaEDBDEEonr+M6hsbD2Iv2mi7LD
         TDC3mrI/XvXi+2S7QFow0WmtAFJ7/2I2EId0S6cLLhUDIbs+t6B+SQgHJwXME+kAEZAN
         bQfT2yyuzpnKyLiXKBCpm8VBAi21SlU+aEjFzkFmEe9/5Ea3XPPG24PgS/nIGL1+R2Lo
         K1qvVJzhgCan8EvAIIpK1QH5HCetenYTadGM/wAl4l70cOwlADAJfvxavyYrKMBxMFbv
         WPIWPLdennbyPwd/l2BFTSYSnLUIXU9JjdluWruBFY4oAWMb78gjeQ0IFz6sBOq6jFkA
         +3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YMzh6ohccmoq8aH/L2hJKrm4rl1SlByXPnUDhSvoKrM=;
        b=PB9/by2du1k7bir4OXM+/Nw/nRubBY7Kn0CQp91WrJpWGjYRfw4SFfCVH7zYlgwEzD
         Z2cOcxC+5HTiO1OHN/4XRkf70aW4BkCDtr6rxJ48KXDS+HH8KaFYvR+xckW6ITgwizMB
         lMT2oVctRlxoL64s3gzMTHi2qARdmcQe0f83UNJ9Cq+OBSYUe+Igt+iWOyitzI04Jq/b
         jQuuU8iAcb//wix14eQS68IFC31vYBk2n6Y5noFbwlvFUTPGLIrL4FDijYnF7WgfdxqM
         hSCsCdku8BYmkbamC2c8Z9Ydp1Y21rY5047+704c28dv+L6y6+S9u6zOKLjiyu0WpdJG
         YR5g==
X-Gm-Message-State: APjAAAVskwr30VBo+JgdQwfcEfEMVnlr8eiDzL0qlsMG9rK87ZLIWCw0
        +sR3uxCDwhQljMuAiVhRbko=
X-Google-Smtp-Source: APXvYqyeHIQQel0+BinG1fJLlfaea/kMkmFVfgKPG1B+8tZV7KPMrlI0MFz9GBeGW8xkJuB+PKC+Bg==
X-Received: by 2002:a7b:c5c2:: with SMTP id n2mr1015976wmk.20.1569270033559;
        Mon, 23 Sep 2019 13:20:33 -0700 (PDT)
Received: from ?IPv6:2001:a61:243d:bf01:c49e:ef23:e680:96b1? ([2001:a61:243d:bf01:c49e:ef23:e680:96b1])
        by smtp.gmail.com with ESMTPSA id v4sm18304005wrg.56.2019.09.23.13.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 13:20:32 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Daniel Colascione <dancol@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: For review: pidfd_open(2) manual page
To:     Florian Weimer <fw@deneb.enyo.de>
References: <90399dee-53d8-a82c-3871-9ec8f94601ce@gmail.com>
 <87tv939td6.fsf@mid.deneb.enyo.de>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <63566f1f-667d-50ca-ae85-784924d09af4@gmail.com>
Date:   Mon, 23 Sep 2019 22:20:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87tv939td6.fsf@mid.deneb.enyo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Florian,

Thanks for taking a look at this page.

On 9/23/19 12:53 PM, Florian Weimer wrote:
> * Michael Kerrisk:
> 
>> SYNOPSIS
>>        int pidfd_open(pid_t pid, unsigned int flags);
> 
> Should this mention <sys/types.h> for pid_t?

Seems reasonable. I added this.

>> ERRORS
>>        EINVAL flags is not 0.
>>
>>        EINVAL pid is not valid.
>>
>>        ESRCH  The process specified by pid does not exist.
> 
> Presumably, EMFILE and ENFILE are also possible errors, and so is
> ENOMEM.

Thanks. I've added those.

>>        A  PID  file descriptor can be monitored using poll(2), select(2),
>>        and epoll(7).  When the process that it refers to terminates,  the
>>        file descriptor indicates as readable.  Note, however, that in the
>>        current implementation, nothing can be read from the file descrip‐
>>        tor.
> 
> “is indicated as readable” or “becomes readable”?  Will reading block?

It won't block. Reads from a pidfd always fail with the error EINVAL
(regardless of whether the target process has terminated).

I specifically wanted to avoid "becomes readable" to avoid any
suggestion that read() does something for a pidfd. I thought 
"indicates as readable" was fine, but you, Christian and Joel 
all called this wording out, so I changed this to:

"When the process that it refers to terminates,
these interfaces indicate the file descriptor as readable."

>>        The  pidfd_open()  system call is the preferred way of obtaining a
>>        PID file descriptor.  The alternative is to obtain a file descrip‐
>>        tor by opening a /proc/[pid] directory.  However, the latter tech‐
>>        nique is possible only if the proc(5) file system is mounted; fur‐
>>        thermore,  the  file  descriptor  obtained in this way is not pol‐
>>        lable.
> 
> One question is whether the glibc wrapper should fall back back to the
> /proc subdirectory if it is not available.  Probably not.

No, since the FD returned by opening /proc/PID is less functional
(it is not pollable) than the one returned by pidfd_open().

>>        static
>>        int pidfd_open(pid_t pid, unsigned int flags)
>>        {
>>            return syscall(__NR_pidfd_open, pid, flags);
>>        }
> 
> Please call this function something else (not pidfd_open), so that the
> example continues to work if glibc provides the system call wrapper.

I figured that if the syscall does get added to glibc, then I would
modify the example. In the meantime, this does seem the most natural
way of doing things, since the example then uses the real syscall
name as it would be used if there were a wrapper function.
 
But, this leads to the question: what do you think the likelihood
is that this system call will land in glibc?

Thanks for your feedback, Florian. I've pushed various changes
to the Git branch at 
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/log/?h=draft_pidfd

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
