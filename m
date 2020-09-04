Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5F825E1E8
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 21:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgIDTUB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Fri, 4 Sep 2020 15:20:01 -0400
Received: from albireo.enyo.de ([37.24.231.21]:36510 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbgIDTUB (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 4 Sep 2020 15:20:01 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kEHFf-0005Q2-Bo; Fri, 04 Sep 2020 19:19:59 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1kEHFf-0003P6-8r; Fri, 04 Sep 2020 21:19:59 +0200
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
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [RESEND RFC PATCH 0/5] Remote mapping
References: <20200904113116.20648-1-alazar@bitdefender.com>
Date:   Fri, 04 Sep 2020 21:19:59 +0200
In-Reply-To: <20200904113116.20648-1-alazar@bitdefender.com> ("Adalbert
        \=\?utf-8\?Q\?Laz\=C4\=83r\=22's\?\= message of "Fri, 4 Sep 2020 14:31:11 +0300")
Message-ID: <87pn71gxi8.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Adalbert Lazăr:

>>> - the control plane accepts three ioctls
>>>
>>> PIDFD_MEM_MAP takes a struct like
>>>
>>>     struct pidfd_mem_map {
>>>          uint64_t address;
>>>          off_t offset;
>>>          off_t size;
>>>          int flags;
>>>          int padding[7];
>>>     }
>>>
>>> After this is done, the memory access fd can be mmap-ed at range
>>> [offset,
>>> offset+size), and it will read memory from range [address,
>>> address+size) of the target descriptor.
>>>
>>> PIDFD_MEM_UNMAP takes a struct like
>>>
>>>     struct pidfd_mem_unmap {
>>>          off_t offset;
>>>          off_t size;
>>>     }
>>>
>>> and unmaps the corresponding range of course.

off_t depends on preprocessor macros (_FILE_OFFSET_BITS), so these
types should be uint64_t, too.

I'm not sure what the advantage is of returning separate file
descriptors, and nit operating directly on the pidfd.
