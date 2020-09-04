Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE13025E1D9
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 21:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgIDTSv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Fri, 4 Sep 2020 15:18:51 -0400
Received: from albireo.enyo.de ([37.24.231.21]:36400 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbgIDTSu (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 4 Sep 2020 15:18:50 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kEHEQ-0005My-JN; Fri, 04 Sep 2020 19:18:42 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1kEHEQ-0003MY-H3; Fri, 04 Sep 2020 21:18:42 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Adalbert =?utf-8?Q?Laz=C4=83r?= <alazar@bitdefender.com>
Cc:     linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mihai =?utf-8?Q?Don=C8=9Bu?= <mdontu@bitdefender.com>,
        Mircea Cirjaliu <mcirjaliu@bitdefender.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [RESEND RFC PATCH 5/5] pidfd_mem: implemented remote memory mapping system call
References: <20200904113116.20648-1-alazar@bitdefender.com>
        <20200904113116.20648-6-alazar@bitdefender.com>
Date:   Fri, 04 Sep 2020 21:18:42 +0200
In-Reply-To: <20200904113116.20648-6-alazar@bitdefender.com> ("Adalbert
        \=\?utf-8\?Q\?Laz\=C4\=83r\=22's\?\= message of "Fri, 4 Sep 2020 14:31:16 +0300")
Message-ID: <87tuwdgxkd.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Adalbert Lazăr:

> +/**
> + * pidfd_mem() - Allow access to process address space.
> + *
> + * @pidfd: pid file descriptor for the target process
> + * @fds:   array where the control and access file descriptors are returned
> + * @flags: flags to pass
> + *
> + * This creates a pair of file descriptors used to gain access to the
> + * target process memory. The control fd is used to establish a linear
> + * mapping between an offset range and a userspace address range.
> + * The access fd is used to mmap(offset range) on the client side.
> + *
> + * Return: On success, 0 is returned.
> + *         On error, a negative errno number will be returned.
> + */
> +SYSCALL_DEFINE3(pidfd_mem, int, pidfd, int __user *, fds, unsigned int, flags)

Structs are cheap.  Can you use a struct pointer for the fds argument?
