Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849E02F0FFE
	for <lists+linux-api@lfdr.de>; Mon, 11 Jan 2021 11:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbhAKKVk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Jan 2021 05:21:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22804 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728993AbhAKKVj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Jan 2021 05:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610360413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yzn7R+ybt4zZMlfDYBceM0A1+kAc0XBV/N3/sB4I1Fw=;
        b=eFq2OEbraCqnb+p5T7nKpdCmHLrcc8glc6nzhYeKyzU3D5h62odDQkfV75joMdiPbgCCuu
        dVccovQLV8w3Lv7l2xSPtsonO4mvdfndySsk6iT8wDvVG8jqdV8drTYHOfH2of2prHUF0Q
        64R45cCMdpME+hPZrV/LbUw/Zv79thQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-0ns8inMANo6v5n0hrddygQ-1; Mon, 11 Jan 2021 05:20:08 -0500
X-MC-Unique: 0ns8inMANo6v5n0hrddygQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CC1819251A9;
        Mon, 11 Jan 2021 10:20:06 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-113-100.ams2.redhat.com [10.36.113.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8048974449;
        Mon, 11 Jan 2021 10:20:03 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, jannh@google.com, keescook@chromium.org,
        jeffv@google.com, minchan@kernel.org, mhocko@suse.com,
        shakeelb@google.com, rientjes@google.com, edgararriaga@google.com,
        timmurray@google.com, linux-mm@kvack.org, selinux@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/1] mm/madvise: replace ptrace attach requirement for
 process_madvise
References: <20210108205857.1471269-1-surenb@google.com>
Date:   Mon, 11 Jan 2021 11:20:01 +0100
In-Reply-To: <20210108205857.1471269-1-surenb@google.com> (Suren
        Baghdasaryan's message of "Fri, 8 Jan 2021 12:58:57 -0800")
Message-ID: <875z43rd0u.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Suren Baghdasaryan:

> diff --git a/mm/madvise.c b/mm/madvise.c
> index 6a660858784b..c2d600386902 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1197,12 +1197,22 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
>  		goto release_task;
>  	}
>  
> -	mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
> +	/* Require PTRACE_MODE_READ to avoid leaking ASLR metadata. */
> +	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
>  	if (IS_ERR_OR_NULL(mm)) {
>  		ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
>  		goto release_task;
>  	}

Shouldn't this depend on the requested behavior?  Several operations
directly result in observable changes, and go beyond performance tuning.

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

