Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C579BBCCF
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2019 22:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502605AbfIWU1v (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Sep 2019 16:27:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38286 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502242AbfIWU1v (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 23 Sep 2019 16:27:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id l11so15418892wrx.5;
        Mon, 23 Sep 2019 13:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AbUP12rGj/CZEVhO+mYx+MU1l+cvHcyXYpvPj7gYcac=;
        b=Z/Wweww8ps6d0ZhEePL3/mTMnxm6cMvy148elrZeGuqjrS3VMlkQLIzVmsNrLvKIRg
         AJ3Gik07jHAlMw/SpOZdxpjRD7uWKZ8z9EjkXUHcfrOUnsaf2i9jj+JLPm5pyjPng76R
         pUijhEJ/We8BeyBOEwVQszaHOn6X8ttTTdwyx/YxWS7olXhP37FTDk08A6jSIPpuzPHG
         devGmOYKt/n9PONYY3oeNnhmhB6ggBTtT8R4Hwtn2VbC1SU6+jv7ff6KBgr08ZWVhwFa
         RBfQoKJjpHj1df2OAR7E7IcZCVzzG+nW/aGgm1dJYQca2sP26T46O4Ot6/XogqVepkwW
         LhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AbUP12rGj/CZEVhO+mYx+MU1l+cvHcyXYpvPj7gYcac=;
        b=ivbx10vBzXG4xZop64irLP0h51T8mhpqwBlk+jE8TW7GmcXluw7tOhh/HTzODtF17h
         S45zd/qljUdMiUgrR0F26sOheAMNwxRas3zHTLX4bH3olnLKHvHDlmvcEaBTu6xSISg7
         ytFnpENjbNf0S2Qkf29oWLvIS+SX8+LsYcwCyBIvqMi/4j0CPeeD99Ll3HaGsa9Fupk3
         ue2pBQt4aGX6H61h3BszA9RJuzyMDw6vWSpFpBjWIDNDqdnIBkSLv9gwREERkg+gPmtZ
         EmeCMudvGQniGw98xvy+k2bEEreCEr3kkcsIHqQQT0VvXgYmq7LLldK+RBGES16nwUyt
         6FqA==
X-Gm-Message-State: APjAAAXtjHS6S0j6gdIRCgPtaQ9S0dyWqMcBWcNieaV0tVQUCJnuudYm
        mPle6zvQ03bQUmI6z1ImxXIwJv4E
X-Google-Smtp-Source: APXvYqwo1lp+AnpWR7ds6msvGHaqG0Rh3PDRlt21U/3ZsRYf+fZ8H+EHoPpDTobiCqGbfRtPgO0MOg==
X-Received: by 2002:a5d:424c:: with SMTP id s12mr852087wrr.221.1569270468974;
        Mon, 23 Sep 2019 13:27:48 -0700 (PDT)
Received: from ?IPv6:2001:a61:243d:bf01:c49e:ef23:e680:96b1? ([2001:a61:243d:bf01:c49e:ef23:e680:96b1])
        by smtp.gmail.com with ESMTPSA id z125sm1744318wme.37.2019.09.23.13.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 13:27:48 -0700 (PDT)
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
To:     Christian Brauner <christian.brauner@ubuntu.com>
References: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com>
 <20190923142932.2gujbddnzyp4ujeu@wittgenstein>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <ca28a4d7-0c0e-2dee-b875-dc28b5dd0f0c@gmail.com>
Date:   Mon, 23 Sep 2019 22:27:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190923142932.2gujbddnzyp4ujeu@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Christian,

On 9/23/19 4:29 PM, Christian Brauner wrote:
> On Mon, Sep 23, 2019 at 11:12:00AM +0200, Michael Kerrisk (man-pages) wrote:
>> Hello Christian and all,
>>
>> Below, I have the rendered version of the current draft of
>> the pidfd_send_signal(2) manual page that I have written.
>> The page source can be found in a Git branch at:
>> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/log/?h=draft_pidfd
>>
>> I would be pleased to receive corrections and notes on any
>> details that should be added. (For example, are there error
>> cases that I have missed?)
>>
>> Would you be able to review please?
> 
> Michael,
> 
> A big big thank you for doing this! Really appreciated.
> I'm happy to review this!
> 
>>
>> Thanks,
>>
>> Michael
>>
>>
>> NAME
>>        pidfd_send_signal - send a signal to a process specified by a file
>>        descriptor
>>
>> SYNOPSIS
>>        int pidfd_send_signal(int pidfd, int sig, siginfo_t info,
>>                              unsigned int flags);
>>
>> DESCRIPTION
>>        The pidfd_send_signal() system call sends the signal  sig  to  the
>>        target  process  referred  to by pidfd, a PID file descriptor that
>>        refers to a process.
>>
>>        If the info argument points to a  siginfo_t  buffer,  that  buffer
>>        should be populated as described in rt_sigqueueinfo(2).
>>
>>        If  the  info  argument  is  a NULL pointer, this is equivalent to
>>        specifying a pointer to a siginfo_t buffer whose fields match  the
>>        values  that  are  implicitly supplied when a signal is sent using
>>        kill(2):
>>
>>        *  si_signo is set to the signal number;
>>        *  si_errno is set to 0;
>>        *  si_code is set to SI_USER;
>>        *  si_pid is set to the caller's PID; and
>>        *  si_uid is set to the caller's real user ID.
>>
>>        The calling process must either be in the same  PID  namespace  as
>>        the  process  referred  to  by pidfd, or be in an ancestor of that
>>        namespace.
>>
>>        The flags argument is reserved for  future  use;  currently,  this
>>        argument must be specified as 0.
>>
>> RETURN VALUE
>>        On  success,  pidfd_send_signal()  returns  0.   On success, -1 is
> 
> This should probably be "On error, -1 is [...]".

Thanks. Fixed.


Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
