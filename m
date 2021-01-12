Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7696E2F378E
	for <lists+linux-api@lfdr.de>; Tue, 12 Jan 2021 18:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbhALRqo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 Jan 2021 12:46:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53810 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726184AbhALRqo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 Jan 2021 12:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610473518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UtXNxOfoGCKDagwh9KvdJdksaWedmeH08MP3xlhXpmg=;
        b=UVtKXRc3fyUPjyCEyThKHw8NGHYuGaK5V8/uVvNTOJOuGodHAzvMRRHmu0hn2ZUEg4YQvN
        S2W1B0g6S9Dp3L6KoF2PLj+hmC4gzRkLY8xI1lGefBx3FsZmAek0cifsVCFVwx6dScAf/O
        shwsWja49Zn+11uQmfvmMzsUpV3Wx4s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-sSfbHYQxMqKvCIuZtw0ARw-1; Tue, 12 Jan 2021 12:45:16 -0500
X-MC-Unique: sSfbHYQxMqKvCIuZtw0ARw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D49CE190D345;
        Tue, 12 Jan 2021 17:45:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.47])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2698E100164C;
        Tue, 12 Jan 2021 17:45:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 12 Jan 2021 18:45:13 +0100 (CET)
Date:   Tue, 12 Jan 2021 18:45:08 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        jannh@google.com, keescook@chromium.org, jeffv@google.com,
        minchan@kernel.org, shakeelb@google.com, rientjes@google.com,
        edgararriaga@google.com, timmurray@google.com, linux-mm@kvack.org,
        selinux@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/1] mm/madvise: replace ptrace attach requirement for
 process_madvise
Message-ID: <20210112174507.GA23780@redhat.com>
References: <20210111170622.2613577-1-surenb@google.com>
 <20210112074629.GG22493@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112074629.GG22493@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 01/12, Michal Hocko wrote:
>
> On Mon 11-01-21 09:06:22, Suren Baghdasaryan wrote:
>
> > What we want is the ability for one process to influence another process
> > in order to optimize performance across the entire system while leaving
> > the security boundary intact.
> > Replace PTRACE_MODE_ATTACH with a combination of PTRACE_MODE_READ
> > and CAP_SYS_NICE. PTRACE_MODE_READ to prevent leaking ASLR metadata
> > and CAP_SYS_NICE for influencing process performance.
>
> I have to say that ptrace modes are rather obscure to me. So I cannot
> really judge whether MODE_READ is sufficient. My understanding has
> always been that this is requred to RO access to the address space. But
> this operation clearly has a visible side effect. Do we have any actual
> documentation for the existing modes?
>
> I would be really curious to hear from Jann and Oleg (now Cced).

Can't comment, sorry. I never understood these security checks and never tried.
IIUC only selinux/etc can treat ATTACH/READ differently and I have no idea what
is the difference.

Oleg.

