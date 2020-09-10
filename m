Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A7A264A28
	for <lists+linux-api@lfdr.de>; Thu, 10 Sep 2020 18:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgIJQo6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Sep 2020 12:44:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56178 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725831AbgIJQnp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Sep 2020 12:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599756194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TgSJjTXbpkXh2o0gkcQWD9wwqe3worwk3nJzHA/vWWg=;
        b=OWTprGlgaNS3Bg73XwwpR4AIE/Us9t7MxyNxCuidWnn6RGhsgcHawaaQ3gxbUFu3M1zMB6
        eVniJbYEJmG4QKfCotv8iqm4rXoDL4nMPyq3gv73hIAjBtdcP/nhmTfR9FN4+MQ2bp9bt8
        XYn+pNCC2iaW+cZbR9kFiaaxjAu/jTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-TeaD4IRHOQaY8UHnGtFJPg-1; Thu, 10 Sep 2020 12:43:10 -0400
X-MC-Unique: TeaD4IRHOQaY8UHnGtFJPg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CF81801AEA;
        Thu, 10 Sep 2020 16:43:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.89])
        by smtp.corp.redhat.com (Postfix) with SMTP id 26F737EEC9;
        Thu, 10 Sep 2020 16:43:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 10 Sep 2020 18:43:08 +0200 (CEST)
Date:   Thu, 10 Sep 2020 18:43:03 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
Cc:     Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [RESEND RFC PATCH 4/5] mm/remote_mapping: use a pidfd to access
 memory belonging to unrelated process
Message-ID: <20200910164302.GA12976@redhat.com>
References: <20200904113116.20648-1-alazar@bitdefender.com>
 <20200904113116.20648-5-alazar@bitdefender.com>
 <20200907143008.GB31050@redhat.com>
 <AM7PR02MB608232256B97797EDE394552BB260@AM7PR02MB6082.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM7PR02MB608232256B97797EDE394552BB260@AM7PR02MB6082.eurprd02.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 09/09, Mircea CIRJALIU - MELIU wrote:
>
> > From: Oleg Nesterov <oleg@redhat.com>
> >
> > But why is it safe to drop ->mmap_sem without checking
> > FAULT_FLAG_ALLOW_RETRY/RETRY_NOWAIT ?
> >
> Dropping mmap_sem will have the same effects regardless of FAULT_FLAG_ALLOW_RETRY/RETRY_NOWAIT.
> Another thread can unmap the VMA from underneath us, or remap another one in its place.
> In the end, the VMA has to be revalidated when re-acquiring the mmap_sem.
> Or am I wrong?!

To simplify, lets forget about RETRY_NOWAIT/TRIED.

Again, I can be easily wrong. But iiuc, you simply can't drop mmap_sem
if FAULT_FLAG_ALLOW_RETRY is not set, the caller doesn't expect mmap_sem
can be unlocked.

OTOH, if FAULT_FLAG_ALLOW_RETRY is set and you drop mmap_sem, you can
only return VM_FAULT_RETRY to let the caller know it was dropped.

> > > +	 * If FAULT_FLAG_ALLOW_RETRY is set, the mmap_sem must be
> > released
> > > +	 * before returning VM_FAULT_RETRY only if
> > FAULT_FLAG_RETRY_NOWAIT is
> > > +	 * not set.
> >
> > Well, iiuc FAULT_FLAG_ALLOW_RETRY means that ->fault() _can_ drop
> > mmap_sem and return VM_FAULT_RETRY (unless NOWAIT).
>
> That comment is just copied from elsewhere in the code.
> My interpretation was that the fault handler _should_ return with mmap_sem
> held or not depending on FAULT_FLAG_RETRY_NOWAIT.

Yes, this depends on FAULT_FLAG_RETRY_NOWAIT.

But your comment above looks as if he mmap_sem must be _always_ released
if FAULT_FLAG_ALLOW_RETRY && !FAULT_FLAG_RETRY_NOWAIT. This is not true.


Nevermind. If you ever resend this patch, please CC mm/ experts. I tried
to look at this code again and I feel it has much more problems, but as
I said this is not my area.

And I think you should split this patch, mirror_vm_fault() should come in
a separate patch to simplify the review.

Oleg.

