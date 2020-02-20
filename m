Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 441E01666F4
	for <lists+linux-api@lfdr.de>; Thu, 20 Feb 2020 20:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgBTTOg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Feb 2020 14:14:36 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43250 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbgBTTOg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Feb 2020 14:14:36 -0500
Received: by mail-pl1-f195.google.com with SMTP id p11so1909330plq.10;
        Thu, 20 Feb 2020 11:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h9IQQUeC9EperJkziFiFFU+AHHaFbtQiLn6EJLG6aXI=;
        b=HeC+npsgBHhiJ8NIcu/dVdd2oXGRPJ3NFOC7+E5vznBVbARU0WycUTo4gFBmcRqweo
         GGrURpmF8J/wkrAvK2EfiBwBxqSTjnaXP3tQ1y0+vAsIfeDnwCb1zFqZYdBjNj+K2D8z
         OwFNPf7m+ieszSqmoZWnTXSAyJHL0lri8Cvpp9iwtx5PvW8HhrT2I+bR+es09KZjGqEV
         4ZA+k7LU5x9V6oq8AZrTI2UzpoQRi8u2lDW6Dz7syIto31tj6co6nyssRfFvNw/BMcCj
         0cxx2fzSVeVRE8/sKDNVZuUTNPWW/LW4AhPTwY33l0L3snhpHpevqTwNIaDfmZRwO1PX
         7xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=h9IQQUeC9EperJkziFiFFU+AHHaFbtQiLn6EJLG6aXI=;
        b=R03CUQiYFYIKD19Bvtgs224cfJsCpoH/ndTbd/XqzOH8Sn4cCXilGkb8TAAI+m+hfL
         qT0gFzfu0a3y0b+gBMKR0J4DvDs5MDf00hun47ohze0UHBj1NF6EFbTFSqj0QZr9Zypp
         9wOQf5WG5hOWRpbGa0ueShnTSZRPUVmbbPgBhNp9iOjQM8ogbLxGh/w6UwIsu+mrkVKy
         ea6UoVuLspLkB4qJtmQ0VtEOWU3p2fhzLL6su9gwdwKFvUHEhPNdhx7Hklanpbm/3F0C
         izKb3EHakoEYzNSS3LR8/k2zNYx8582YGjzC/6FiuU9eLYfkaHWlyj7jin9E2v2vouwS
         8Z8A==
X-Gm-Message-State: APjAAAXko2uGcfFvBOW2EUJd6qnLcCBysgseuFB1i77Ap0hIwyFpMPBu
        BxgWU3B/Xqs6r1csnak/7jg=
X-Google-Smtp-Source: APXvYqw6y7Nhb4vjA5yJoK8XclQcAOEQlx4Y0ZxOWmGiku8xlJ6tQ7PMUsOzidtgo3Q+t0gDUVPNCQ==
X-Received: by 2002:a17:90a:1f8d:: with SMTP id x13mr5471397pja.27.1582226075283;
        Thu, 20 Feb 2020 11:14:35 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id z5sm375930pfq.3.2020.02.20.11.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 11:14:34 -0800 (PST)
Date:   Thu, 20 Feb 2020 11:14:32 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v6 1/2] mm: Add MREMAP_DONTUNMAP to mremap().
Message-ID: <20200220191432.GA180571@google.com>
References: <20200218173221.237674-1-bgeffon@google.com>
 <20200220171554.GA44866@google.com>
 <CADyq12zUEq9kcyuR_Qm9MrU1ii-+9n8T2hK6QNzj=kH5zn0VrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyq12zUEq9kcyuR_Qm9MrU1ii-+9n8T2hK6QNzj=kH5zn0VrA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Feb 20, 2020 at 10:36:38AM -0800, Brian Geffon wrote:
> Hi Minchan,
> 
> > And here we got error if the addr is in non-anonymous-private vma so the
> > syscall will fail but old vma is gone? I guess it's not your intention?
> 
> This is exactly what happens today in several situations, because
> vma_to_resize is called unconditionally. For example if the old vma
> has VM_HUGETLB and old_len < new_len it would have unmapped a portion
> and then in vma_to_resize returned -EINVAL, similarly when old_len = 0
> with a non-sharable mapping it will have called do_munmap only to fail
> in vma_to_resize, if the vma has VM_DONTEXPAND set and you shrink the
> size with old_len < new_len it would return -EFAULT after having done
> the unmap on the decreased portion. So I followed the pattern to keep
> the change simple and maintain consistency with existing behavior.

Fair enough. It seems to be very old existing behavior but man page
never mention about it. :(

> 
> But with that being said, Kirill made the point that resizing a VMA
> while also using MREMAP_DONTUNMAP doesn't have any clear use case and
> I agree with that, I'm unable to think of a situation where you'd want
> to resize a VMA and use MREMAP_DONTUNMAP. So I'm tempted to mail a new
> version which returns -EINVAL if old_len != new_len that would resolve
> this concern here as nothing would be unmapped ever at the old
> position add it would clean up the change to very few lines of code.
> 
> What do you think?

Agreed. That makes code more simple/clean.

Thanks!
