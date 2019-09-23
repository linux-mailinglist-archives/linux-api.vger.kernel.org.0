Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86B38BBCB7
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2019 22:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388044AbfIWUVd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Sep 2019 16:21:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34985 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbfIWUVd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 23 Sep 2019 16:21:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id y21so10673124wmi.0;
        Mon, 23 Sep 2019 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IZFuwfp0buQdmC9H/dLOdJ0Vo8xsZjswQdAWnl59bf0=;
        b=Vph+KSkrf1DF6dc2hfoQSite2oxFhtDcxCp4Kpog9oF9aFHbG4B5B8Or4g5zyXO+xj
         QM/3rLUrQ3PjRyGDBqDxS8nJr3Cg8WD08q8JUhNw4fcHu7iOS7ZSByymAgK7FZRDsOlJ
         gQJB/zNrtOZNeFh9c3UWX9T+MsOTxo+FMbpF7asefLISEhEaIlpsqwUZRheU8ndzLJku
         Tmt9J3bL9tgKcGU65BpLE0fcliou2cRiSzYKEhtpAc4nCpx/a5HHPaZl0QqRU1DgmLef
         AhwQtwNZ5JfmRRqn4zib2E9V9Xo3bzt6muWQyHwcQx5WSeZPCQ1vw0qxNM1nyFAFL697
         nusg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IZFuwfp0buQdmC9H/dLOdJ0Vo8xsZjswQdAWnl59bf0=;
        b=ZtceE9PGGalJryknBV+PojTNVOmFoQiLYEwu8JyjAQHAilz2v7C3TcSHwIVYoaUJEI
         H7WMc/gZ59b8/tu39lAU1zbqFBEnjV6RNi7R1ODjJfth0Z454GkgJHHcY6ghlp0S4LTT
         8CcdM2se9Eh5EXn1vYldTDa0gGVc4IK5E3rCAH04qZ8XzQwQBsESqcwpXQ/oG5sgsOpz
         e8FgbMW6O16KMHTZJhi0JATdGQ9TCsA9Js2YHldp7gtlMjC0iLFI9YGx3ZGKCPML8Iaj
         rDnUSIfOjDTPT+Ysg3cI9t0JD337ofYIS/HwTTIgPz7Bhcqh4YPc1zjvkoaKu47omaEh
         qoFA==
X-Gm-Message-State: APjAAAV66sX//iPCBV0ZlsCopMYj6vlRe8icz7eiHIBKClhujbZy3HjD
        2L2tfWeRhVXQB1UmIx63+JY=
X-Google-Smtp-Source: APXvYqymv5dzR/z5/Km8vggWjSSvzT0o2NDC02wtfP6OeSAIbWIVyNKNEGT0WFdUf4yOpw21uSeR8g==
X-Received: by 2002:a1c:cf8c:: with SMTP id f134mr1060331wmg.174.1569270089935;
        Mon, 23 Sep 2019 13:21:29 -0700 (PDT)
Received: from ?IPv6:2001:a61:243d:bf01:c49e:ef23:e680:96b1? ([2001:a61:243d:bf01:c49e:ef23:e680:96b1])
        by smtp.gmail.com with ESMTPSA id q124sm22149823wma.5.2019.09.23.13.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 13:21:29 -0700 (PDT)
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
To:     Christian Brauner <christian.brauner@ubuntu.com>
References: <90399dee-53d8-a82c-3871-9ec8f94601ce@gmail.com>
 <20190923143846.u7miwgmszecankof@wittgenstein>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <4020cf8e-f29a-730f-d900-3295bda700cb@gmail.com>
Date:   Mon, 23 Sep 2019 22:21:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190923143846.u7miwgmszecankof@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Christian,

On 9/23/19 4:38 PM, Christian Brauner wrote:
> On Mon, Sep 23, 2019 at 11:11:53AM +0200, Michael Kerrisk (man-pages) wrote:
>> Hello Christian and all,
>>
>> Below, I have the rendered version of the current draft of
>> the pidfd_open(2) manual page that I have written.
>> The page source can be found in a Git branch at:
>> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/log/?h=draft_pidfd
>>
>> I would be pleased to receive corrections and notes on any
>> details that should be added. (For example, are there error
>> cases that I have missed?)
>>
>> Would you be able to review please?
> 
> Again, thank you Michael for doing this!
> 
>>
>> Thanks,
>>
>> Michael
>>
>>
>> NAME
>>        pidfd_open - obtain a file descriptor that refers to a process
>>
>> SYNOPSIS
>>        int pidfd_open(pid_t pid, unsigned int flags);
>>
>> DESCRIPTION
>>        The  pidfd_open()  system creates a file descriptor that refers to
> 
> s/system/system call/

Fixed.

>>        the process whose PID is specified in pid.  The file descriptor is
>>        returned  as the function result; the close-on-exec flag is set on
>>        the file descriptor.
>>
>>        The flags argument is reserved for  future  use;  currently,  this
>>        argument must be specified as 0.
>>
>> RETURN VALUE
>>        On  success,  pidfd_open()  returns a nonnegative file descriptor.
>>        On success, -1 is returned and errno is set to indicate the  cause
> 
> s/On success/On error/g

Fixed.

>>        of the error.
>>
>> ERRORS
>>        EINVAL flags is not 0.
>>
>>        EINVAL pid is not valid.
>>
>>        ESRCH  The process specified by pid does not exist.
>>
>> VERSIONS
>>        pidfd_open() first appeared in Linux 5.3.
>>
>> CONFORMING TO
>>        pidfd_open() is Linux specific.
>>
>> NOTES
>>        Currently, there is no glibc wrapper for this system call; call it
>>        using syscall(2).
>>
>>        The pidfd_send_signal(2) system call can be used to send a  signal
>>        to the process referred to by a PID file descriptor.
>>
>>        A  PID  file descriptor can be monitored using poll(2), select(2),
>>        and epoll(7).  When the process that it refers to terminates,  the
>>        file descriptor indicates as readable.  Note, however, that in the
> 
> Not a native English speaker but should this be "indicates it is
> readable"?

See my reply to Florian.

>>        current implementation, nothing can be read from the file descrip‐
>>        tor.
>>
>>        The  pidfd_open()  system call is the preferred way of obtaining a
>>        PID file descriptor.  The alternative is to obtain a file descrip‐
>>        tor by opening a /proc/[pid] directory.  However, the latter tech‐
>>        nique is possible only if the proc(5) file system is mounted; fur‐
>>        thermore,  the  file  descriptor  obtained in this way is not pol‐
>>        lable.
> 
> I mentioned this already in the CLONE_PIDFD manpage, we should probably
> not make a big deal out of this and not mention /proc/<pid> here at all.

The thing is, people *will* learn about these two different types
of FDs, whether we document them or not. So, I think it's better to
be up front about what's available, and make a suitably strong
recommendation about the preferred technique.

Reading between the lines, it sounds like just a couple of releases
after it was implemented, you're saying that implementing
open(/proc/PID) was a mistake?

> (Crazy idea, but we could also have a config option that allows you to
> turn of proc-pid-dirfds as pidfds if we start to feel really strongly
> about this or a sysctl whatever...)
> 
>>
>>        See also the discussion of the CLONE_PIDFD flag in clone(2).
>>
>> EXAMPLE
>>        The program below opens a PID  file  descriptor  for  the  process
>>        whose PID is specified as its command-line argument.  It then mon‐
>>        itors the file descriptor for readability (POLLIN) using  poll(2).
> 
> Yeah, maybe say "monitors the file descriptor for process exit indicated
> by an EPOLLIN event" or something. Readability might be confusing.

I like that suggestion! I reworded to something close to what you suggest.

>>        When  the  process  with  the specified by PID terminates, poll(2)
>>        returns, and indicates that the file descriptor is readable.
> 
> See comment above "readable". (I'm on my phone and I think someone
> pointed this out already.)

Actually, I think I can just remove that sentence. It doesn't really
add much.

>>    Program source
>>
>>        #define _GNU_SOURCE
>>        #include <sys/syscall.h>
>>        #include <unistd.h>
>>        #include <poll.h>
>>        #include <stdlib.h>
>>        #include <stdio.h>
>>
>>        #ifndef __NR_pidfd_open
>>        #define __NR_pidfd_open 434
>>        #endif
> 
> Alpha is special... (and not in a good way).
> So you would need to special case Alpha since that's the only arch where
> we haven't been able to unify syscall numbering. :D
> But it's not super important.

Okay.

> I like the program example.

Good.

Thanks for reviewing! I've pushed various changes
to the Git branch at 
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/log/?h=draft_pidfd


Cheers,

Michael

>>
>>        static
>>        int pidfd_open(pid_t pid, unsigned int flags)
>>        {
>>            return syscall(__NR_pidfd_open, pid, flags);
>>        }
>>
>>        int
>>        main(int argc, char *argv[])
>>        {
>>            struct pollfd pollfd;
>>            int pidfd, ready;
>>
>>            if (argc != 2) {
>>                fprintf(stderr, "Usage: %s <pid>\n", argv[0]);
>>                exit(EXIT_SUCCESS);
>>            }
>>
>>            pidfd = pidfd_open(atoi(argv[1]), 0);
>>            if (pidfd == -1) {
>>                perror("pidfd_open");
>>                exit(EXIT_FAILURE);
>>            }
>>
>>            pollfd.fd = pidfd;
>>            pollfd.events = POLLIN;
>>
>>            ready = poll(&pollfd, 1, -1);
>>            if (ready == -1) {
>>                perror("poll");
>>                exit(EXIT_FAILURE);
>>            }
>>
>>            printf("Events (0x%x): POLLIN is %sset\n", pollfd.revents,
>>                    (pollfd.revents & POLLIN) ? "" : "not ");
>>
>>            exit(EXIT_SUCCESS);
>>        }
>>
>> SEE ALSO
>>        clone(2),  kill(2),  pidfd_send_signal(2),   poll(2),   select(2),
>>        epoll(7)
>>
>>
>> -- 
>> Michael Kerrisk
>> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
>> Linux/UNIX System Programming Training: http://man7.org/training/
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
