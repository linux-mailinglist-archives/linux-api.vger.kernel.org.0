Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83CBFBB11A
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2019 11:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732059AbfIWJL5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Sep 2019 05:11:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45814 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730067AbfIWJL5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 23 Sep 2019 05:11:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id r5so12977998wrm.12;
        Mon, 23 Sep 2019 02:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=TyHsy1K1DQHEShIDELro/SCThFG2dVqERrGj3Si+c7M=;
        b=Z/+vRohuSiTJzXZsAA4UHymFCHbjNjbiXveMN5ZeSBCg8IlWvjJ2G+h1htO4cT5RA1
         f4YdOYTTfzYtY6bZndKDHCW1YXUoUzCZWblAbyDzh/dqamgB4+mW8FrpbucmUkJZIox2
         QGDui9cdenDZwsC+m30G6Ux1/yo0YR7D32b/E858FUb+lwhSjud+jZjtGDToVrHEXJvy
         4GSLbpMMghrX+FFv23H5ulk4TmEvzM0Rdt7fu7hMvkpUcJqHANSM1DtX5LKdCpqm8lLD
         TDEzcpnxV3TOu/zpwXLv78d+aXpmtxXHuxNtvPKTNJChktytOAtpVxKu5m0swXjLgepd
         QxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=TyHsy1K1DQHEShIDELro/SCThFG2dVqERrGj3Si+c7M=;
        b=VAyr9GrgMNQMbuZVIKd4/yNSDQVNakUAxjkQtnPKp4+/AwhtvsZtBV6PWIFUVRuIXZ
         FOTG0I8UgQPYY76GNO6NZ0VAaLTBnYuQUbW9D7WOIW/9pZ/krM5+57bDkSzw5db3Zgal
         EdD74w7rv6r8muX+ZitH7VBwHFTcGYqZdByaVMn1gd5mGdf0kIkYS/emW9YD8lLVyFTy
         2vmnf+Spa6w9Y52WmR1+eLSvHpeDvqaV0Q4Xv1CHqmEtjB41I3uEgKqPv+r85V/mWlXU
         ms6nBlnKznW/BCFCzus5DM4/M/FAHqSnC0AQQnVfTYgdVQW7iM+jrzul4/2fKTHK8JBH
         vqHg==
X-Gm-Message-State: APjAAAWvgJp61ag6GbSywFvrmmZ+nQAbGowPbywX7PdkRSesvIupWK64
        8EbpZ54sz0MHDmb5MKSVodA=
X-Google-Smtp-Source: APXvYqyX7TQi2FYiyba1WGCuTIwKh9tFSXG43jGs7gRKvoMi4+lCG5QNDi9QC9W6fv3HfsPiCsV+eg==
X-Received: by 2002:a5d:51d2:: with SMTP id n18mr19920738wrv.10.1569229914922;
        Mon, 23 Sep 2019 02:11:54 -0700 (PDT)
Received: from [10.0.20.253] ([95.157.63.22])
        by smtp.gmail.com with ESMTPSA id y72sm15396020wmc.26.2019.09.23.02.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 02:11:54 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Daniel Colascione <dancol@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Fernandes <joel@joelfernandes.org>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: For review: pidfd_open(2) manual page
Message-ID: <90399dee-53d8-a82c-3871-9ec8f94601ce@gmail.com>
Date:   Mon, 23 Sep 2019 11:11:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Christian and all,

Below, I have the rendered version of the current draft of
the pidfd_open(2) manual page that I have written.
The page source can be found in a Git branch at:
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/log/?h=draft_pidfd

I would be pleased to receive corrections and notes on any
details that should be added. (For example, are there error
cases that I have missed?)

Would you be able to review please?

Thanks,

Michael


NAME
       pidfd_open - obtain a file descriptor that refers to a process

SYNOPSIS
       int pidfd_open(pid_t pid, unsigned int flags);

DESCRIPTION
       The  pidfd_open()  system creates a file descriptor that refers to
       the process whose PID is specified in pid.  The file descriptor is
       returned  as the function result; the close-on-exec flag is set on
       the file descriptor.

       The flags argument is reserved for  future  use;  currently,  this
       argument must be specified as 0.

RETURN VALUE
       On  success,  pidfd_open()  returns a nonnegative file descriptor.
       On success, -1 is returned and errno is set to indicate the  cause
       of the error.

ERRORS
       EINVAL flags is not 0.

       EINVAL pid is not valid.

       ESRCH  The process specified by pid does not exist.

VERSIONS
       pidfd_open() first appeared in Linux 5.3.

CONFORMING TO
       pidfd_open() is Linux specific.

NOTES
       Currently, there is no glibc wrapper for this system call; call it
       using syscall(2).

       The pidfd_send_signal(2) system call can be used to send a  signal
       to the process referred to by a PID file descriptor.

       A  PID  file descriptor can be monitored using poll(2), select(2),
       and epoll(7).  When the process that it refers to terminates,  the
       file descriptor indicates as readable.  Note, however, that in the
       current implementation, nothing can be read from the file descrip‐
       tor.

       The  pidfd_open()  system call is the preferred way of obtaining a
       PID file descriptor.  The alternative is to obtain a file descrip‐
       tor by opening a /proc/[pid] directory.  However, the latter tech‐
       nique is possible only if the proc(5) file system is mounted; fur‐
       thermore,  the  file  descriptor  obtained in this way is not pol‐
       lable.

       See also the discussion of the CLONE_PIDFD flag in clone(2).

EXAMPLE
       The program below opens a PID  file  descriptor  for  the  process
       whose PID is specified as its command-line argument.  It then mon‐
       itors the file descriptor for readability (POLLIN) using  poll(2).
       When  the  process  with  the specified by PID terminates, poll(2)
       returns, and indicates that the file descriptor is readable.

   Program source

       #define _GNU_SOURCE
       #include <sys/syscall.h>
       #include <unistd.h>
       #include <poll.h>
       #include <stdlib.h>
       #include <stdio.h>

       #ifndef __NR_pidfd_open
       #define __NR_pidfd_open 434
       #endif

       static
       int pidfd_open(pid_t pid, unsigned int flags)
       {
           return syscall(__NR_pidfd_open, pid, flags);
       }

       int
       main(int argc, char *argv[])
       {
           struct pollfd pollfd;
           int pidfd, ready;

           if (argc != 2) {
               fprintf(stderr, "Usage: %s <pid>\n", argv[0]);
               exit(EXIT_SUCCESS);
           }

           pidfd = pidfd_open(atoi(argv[1]), 0);
           if (pidfd == -1) {
               perror("pidfd_open");
               exit(EXIT_FAILURE);
           }

           pollfd.fd = pidfd;
           pollfd.events = POLLIN;

           ready = poll(&pollfd, 1, -1);
           if (ready == -1) {
               perror("poll");
               exit(EXIT_FAILURE);
           }

           printf("Events (0x%x): POLLIN is %sset\n", pollfd.revents,
                   (pollfd.revents & POLLIN) ? "" : "not ");

           exit(EXIT_SUCCESS);
       }

SEE ALSO
       clone(2),  kill(2),  pidfd_send_signal(2),   poll(2),   select(2),
       epoll(7)


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
