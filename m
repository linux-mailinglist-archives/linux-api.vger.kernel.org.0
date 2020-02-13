Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26BDA15BE3F
	for <lists+linux-api@lfdr.de>; Thu, 13 Feb 2020 13:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgBMMH4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 13 Feb 2020 07:07:56 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38080 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbgBMMH4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 13 Feb 2020 07:07:56 -0500
Received: by mail-lj1-f195.google.com with SMTP id w1so6308609ljh.5
        for <linux-api@vger.kernel.org>; Thu, 13 Feb 2020 04:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rd4xaLNS2AIxfYvKAvmcRdDCWeLjTTZtNYujj0pjgMk=;
        b=M2VUGBwXg+/hd3puU06yqac4zRaPvTXXLIfZyt7OjuKT9vRMrYDFEIQohg/D5vOFZQ
         nbg0WHbiwqy/kGwYFjnGfLBMmLqRvuVZSJtsYy0S8L552R0g3ge+GHkCMeTQrK0DBPHS
         w7uqIIdq67ZrCExXrDr9zava1s2YEPAqOHmnWdY45wHHFGhJ1lyfBz5OU6BkjWYmdM1J
         b/fZ4bIf9RHofk698C92yzSG2lGvuXs+Po3PG+jOJvqhBz6KWQgOnfGjKrOTZB28eLjk
         7NCFR097N16PT+COcEm3RBl5PMNU8IS4NgqXMlak3BXwJvhgTbmdof+1ZwDgX7aYlTVL
         V94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rd4xaLNS2AIxfYvKAvmcRdDCWeLjTTZtNYujj0pjgMk=;
        b=oOG9BcMOPxd3j/pA+swlW72jyXMWrWtZtj20ThrGfrbnAsZ2KA82vtKX5gjyQC3i+O
         UaqpPRfqVTTTl6CaravOzzFdI/VkduK5jFzewPUHg2VDtWiHI+3loeDLwHvU3zH2yIzi
         +DCIkqJVqZdVMI2qaDKYK1yAae/aO8WELLcJtm6ZQJWPx2LsJ4oQmpu2gJmOtcdoCdXc
         lyL+Dj9gwMyMA7Bk6Fke6ANbYWlwreu/fITbalVMvwoGuQRZKZVQm+6HvM3mVf2NgSdz
         oJw0A2K4KMJKbZbjSPAhD5PcUivp39OXImMFuUqCErOgNjMnwoE97fJpE5yGWrG2I2MW
         wMyQ==
X-Gm-Message-State: APjAAAUpS4RqJtwc7hVHPSIWl00ntkwAauD53t5YVx6ozXafS5OWyW7p
        Xqaq3XC9WZEeVT2iI+wH7Yusig==
X-Google-Smtp-Source: APXvYqzRZafNFtZ7svPxheBqNfpYjdJ0hTorPlw//lqT7d/AG1y7sL+dI4mgR5yoxZFKIbMgc8OsaA==
X-Received: by 2002:a2e:a402:: with SMTP id p2mr11283717ljn.143.1581595674356;
        Thu, 13 Feb 2020 04:07:54 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z8sm1300685ljc.44.2020.02.13.04.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 04:07:53 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id DE1C5100F24; Thu, 13 Feb 2020 15:08:13 +0300 (+03)
Date:   Thu, 13 Feb 2020 15:08:13 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v4] mm: Add MREMAP_DONTUNMAP to mremap().
Message-ID: <20200213120813.myanzyjmpyzixghf@box>
References: <20200207201856.46070-1-bgeffon@google.com>
 <20200210104520.cfs2oytkrf5ihd3m@box>
 <CADyq12wcwvRLwueucHFV2ErL67etOJdFGYQdqVFM2WAeOkMGQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyq12wcwvRLwueucHFV2ErL67etOJdFGYQdqVFM2WAeOkMGQA@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Feb 10, 2020 at 06:12:39AM -0800, Brian Geffon wrote:
> Hi Kirill,
> If the old_len == new_len then there is no change in the number of
> locked pages they just moved, if the new_len < old_len then the
> process of unmapping (new_len - old_len) bytes from the old mapping
> will handle the locked page accounting. So in this special case where
> we're growing the VMA, vma_to_resize() will enforce that growing the
> vma doesn't exceed RLIMIT_MEMLOCK, but vma_to_resize() doesn't handle
> incrementing mm->locked_bytes which is why we have that special case
> incrementing it here.

But if you do the operation for the VM_LOCKED vma, you'll have two locked
VMA's now, right? Where do you account the old locked vma you left behind?

-- 
 Kirill A. Shutemov
