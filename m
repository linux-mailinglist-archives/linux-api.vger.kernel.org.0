Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C1725FD01
	for <lists+linux-api@lfdr.de>; Mon,  7 Sep 2020 17:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgIGPZ0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 7 Sep 2020 11:25:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40572 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbgIGPYl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 7 Sep 2020 11:24:41 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kFIiK-0004KC-Bk; Mon, 07 Sep 2020 15:05:48 +0000
Date:   Mon, 7 Sep 2020 17:05:47 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>
Cc:     linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>,
        Mircea Cirjaliu <mcirjaliu@bitdefender.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RESEND RFC PATCH 0/5] Remote mapping
Message-ID: <20200907150547.hst4luvrpntdb3lr@wittgenstein>
References: <20200904113116.20648-1-alazar@bitdefender.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200904113116.20648-1-alazar@bitdefender.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 04, 2020 at 02:31:11PM +0300, Adalbert Lazăr wrote:
> This patchset adds support for the remote mapping feature.
> Remote mapping, as its name suggests, is a means for transparent and
> zero-copy access of a remote process' address space.
> access of a remote process' address space.
> 
> The feature was designed according to a specification suggested by
> Paolo Bonzini:
> >> The proposed API is a new pidfd system call, through which the parent
> >> can map portions of its virtual address space into a file descriptor
> >> and then pass that file descriptor to a child.
> >>
> >> This should be:
> >>
> >> - upstreamable, pidfd is the new cool thing and we could sell it as a
> >> better way to do PTRACE_{PEEK,POKE}DATA

In all honesty, that sentence made me a bit uneasy as it reads like this
is implemented on top of pidfds because it makes it more likely to go
upstream not because it is the right design. To be clear, I'm not
implying any sort of malicious intent on your part but I would suggest
to phrase this a little better. :)
