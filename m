Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5730BD3ED
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2019 23:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfIXVAJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Sep 2019 17:00:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38729 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfIXVAI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Sep 2019 17:00:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so1717457wmi.3;
        Tue, 24 Sep 2019 14:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oNewvcf++KWCtPFvvVi+ibAYpjhcVn6V1aXTpiHE3I0=;
        b=TW9l9J5wsC6Xo4aE9YxCuHSL3SI84uUP0Ahm6cBvBEQ/L2/1zkCnHUTNNyrpivXBeS
         v0HlerVRib3YwY9ZEBCoe9ZPcSmOHvfG4hJ1bv/khZ7IvIZFxrlUCclx7pUfqeLYM/wl
         9dHhnln92sHgTBETNzWou/TRjqJAsK8Ix7mODZzDKUSIZigS6RUnvWtnE8djjMN40Qqx
         g2nz7hj5rVa1DmDOZILK4vD50FVo9rlfoF0K0C1tAVocUavMEXFgNk09XjlQ6jQ1SAuu
         GZunPUF3YVxZAGX8sK/RoHJhQ76Wdc3g1OrJx845/OomxPwy/5kinQh60LSIz+P68MSe
         03fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oNewvcf++KWCtPFvvVi+ibAYpjhcVn6V1aXTpiHE3I0=;
        b=B0MoQNilR0BOQPyKxR8FQGOMzmEhk3dP48LnrdsKkvtvLtJz+4s7sydkR7kmkI7ABB
         ut9WY4QKwZsZBCIlFEo+ouga+970mkCdpC1Xwwlz2wSchdTDnfzF+XLwEbZarwChnfDq
         Uer12S0OMtg3AYGCWdkjINqaW/SPdl8b3eWqQ6+qto0/H2fp1f1FjYChZhqPI0nGs8LT
         bwpaaRxYlJjlOnfWjUq6LGIOScqFwfgAdZzrxBL1NaF1eCcez6IFVpFCwoFItIUWIjey
         v52QWqm/G+LmatAZEyNJ0Pb6c3RP/SUh0rR19cnonnwwg53OZOzbulmJLomqSCYS0Q7V
         Seew==
X-Gm-Message-State: APjAAAUhIKA3HV7iRGV3IuX3pDLYiCTqJA+NqRP1G308bBzx7ZzCLcFI
        dDvNyIizyxKgNpfcGqE13WXX+6wT
X-Google-Smtp-Source: APXvYqwQ/T+RidUBMADAgvS0I04mGILCXbTh+L5jSqpYYSJGw6ALpjsu4wzXySkpvCn2V4pzeH9fng==
X-Received: by 2002:a7b:cd99:: with SMTP id y25mr2518764wmj.152.1569358804992;
        Tue, 24 Sep 2019 14:00:04 -0700 (PDT)
Received: from ?IPv6:2001:a61:24d6:4e01:ef75:e978:47cd:1c50? ([2001:a61:24d6:4e01:ef75:e978:47cd:1c50])
        by smtp.gmail.com with ESMTPSA id z13sm3169830wrq.51.2019.09.24.14.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 14:00:03 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Florian Weimer <fw@deneb.enyo.de>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: For review: pidfd_send_signal(2) manual page
To:     Christian Brauner <christian.brauner@ubuntu.com>
References: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com>
 <87pnjr9rth.fsf@mid.deneb.enyo.de>
 <20190923142325.jowzbnwjw7g7si7j@wittgenstein>
 <90dd38d5-34b3-b72f-8e5a-b51f944f22fb@gmail.com>
 <20190924195701.7pw2olbviieqsg5q@wittgenstein>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <b76adb4c-826b-6493-ba75-a9863066d3b1@gmail.com>
Date:   Tue, 24 Sep 2019 23:00:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190924195701.7pw2olbviieqsg5q@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Christian,

>>> If you're the parent of the process you can do this without CLONE_PIDFD:
>>> pid = fork();
>>> pidfd = pidfd_open();
>>> ret = pidfd_send_signal(pidfd, 0, NULL, 0);
>>> if (ret < 0 && errno == ESRCH)
>>> 	/* pidfd refers to another, recycled process */
>>
>> Although there is still the race between the fork() and the
>> pidfd_open(), right?
> 
> Actually no and my code is even too complex.
> If you are the parent, and this is really a sequence that obeys the
> ordering pidfd_open() before waiting:
> 
> pid = fork();
> if (pid == 0)
> 	exit(EXIT_SUCCESS);
> pidfd = pidfd_open(pid, 0);
> waitid(pid, ...);
> 
> Then you are guaranteed that pidfd will refer to pid. No recycling can
> happen since the process has not been waited upon yet (That is,

D'oh! Yes, of course. 

> excluding special cases such as where you have a mainloop where a
> callback reacts to a SIGCHLD event and waits on the child behind your
> back and your next callback in the mainloop calls pidfd_open() while the
> pid has been recycled etc.).
> A race could only appear in sequences where waiting happens before
> pidfd_open():
> 
> pid = fork();
> if (pid == 0)
> 	exit(EXIT_SUCCESS);
> waitid(pid, ...);
> pidfd = pidfd_open(pid, 0);
> 
> which honestly simply doesn't make any sense. So if you're the parent
> and you combine fork() + pidfd_open() correctly things should be fine
> without even having to verify via pidfd_send_signal() (I missed that in
> my first mail.).

Thanks for the additional detail.

I added the following to the pidfd_open() page, to
prevent people making the same thinko as me:

       The following code sequence can be used to obtain a file  descrip‐
       tor for the child of fork(2):

           pid = fork();
           if (pid > 0) {     /* If parent */
               pidfd = pidfd_open(pid, 0);
               ...
           }

       Even  if  the  child process has already terminated by the time of
       the pidfd_open() call, the returned file descriptor is  guaranteed
       to refer to the child because the parent has not yet waited on the
       child (and therefore, the child's ID has not been recycled).

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
