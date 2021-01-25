Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7C7304808
	for <lists+linux-api@lfdr.de>; Tue, 26 Jan 2021 20:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbhAZFwd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 Jan 2021 00:52:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:48444 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728757AbhAYNVT (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 25 Jan 2021 08:21:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611580783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hvyCg1tArEMURZiCaw0o7rfIdGticTsjrcjPx+/JdNc=;
        b=A4Vm72+PELLClS/Iy715Uik0vACGATsRtA2iQMVkLUk7pB1NNEp+sD+oPc2YAwpCTCYFWo
        S6cgCM5W61YrqU3UsTpXfJsNEmMTLpZ92x7E+4u1Hve30Vlh8wUkj93JfsZaBNc0InUmqa
        E/9B6Y8rEAQXzzf6L5pfNetYN4lnJf8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D4325AAC6;
        Mon, 25 Jan 2021 13:19:42 +0000 (UTC)
Date:   Mon, 25 Jan 2021 14:19:35 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     linux-man@vger.kernel.org, akpm@linux-foundation.org,
        jannh@google.com, keescook@chromium.org, jeffv@google.com,
        minchan@kernel.org, shakeelb@google.com, rientjes@google.com,
        edgararriaga@google.com, timmurray@google.com, linux-mm@kvack.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/1] process_madvise.2: Add process_madvise man page
Message-ID: <20210125131935.GI827@dhcp22.suse.cz>
References: <20210120202337.1481402-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120202337.1481402-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 20-01-21 12:23:37, Suren Baghdasaryan wrote:
[...]
>     MADV_COLD (since Linux 5.4.1)
>         Deactivate a given range of pages by moving them from active to
>         inactive LRU list. This is done to accelerate the reclaim of these
>         pages. The advice might be ignored for some pages in the range when it
>         is not applicable.

I do not think we want to talk about active/inactive LRU lists here.
Wouldn't it be sufficient to say
Deactive a given range of pages which will make them a more probable
reclaim target should there be a memory pressure. This is a
non-destructive operation.

Other than that, looks good to me from the content POV.

Thanks!
-- 
Michal Hocko
SUSE Labs
