Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6548425D57B
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 11:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbgIDJyx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 05:54:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34589 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729824AbgIDJyw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Sep 2020 05:54:52 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kE8QZ-0007oK-CM; Fri, 04 Sep 2020 09:54:39 +0000
Date:   Fri, 4 Sep 2020 11:54:38 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>, linux-api@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Remote mapping
Message-ID: <20200904095438.q3vuihvfivhdjvxs@wittgenstein>
References: <20200903174730.2685-1-alazar@bitdefender.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200903174730.2685-1-alazar@bitdefender.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 03, 2020 at 08:47:25PM +0300, Adalbert Lazăr wrote:
> This patchset adds support for the remote mapping feature.
> Remote mapping, as its name suggests, is a means for transparent and
> zero-copy access of a remote process' address space.
> access of a remote process' address space.

Hey Adalbert,

Thanks for the patch. When you resend this patch series, could you
please make sure that everyone Cced on any individual patch receives the
full patch series? I only got patch 5/5 and it's a bit annoying because
one completely lacks context of what's going on. I first thought "did
someone just add a syscall with 3 lines of commit message?". :)

Could you please resend the patch series with linux-api, me and the
following people Cced:

Andy Lutomirski <luto@kernel.org>
Arnd Bergmann <arnd@arndb.de>
Sargun Dhillon <sargun@sargun.me>
Aleksa Sarai <cyphar@cyphar.com>
Oleg Nesterov <oleg@redhat.com>
Jann Horn <jannh@google.com>
Kees Cook <keescook@chromium.org>
Matthew Wilcox <willy@infradead.org>
linux-api@vger.kernel.org

Christian
