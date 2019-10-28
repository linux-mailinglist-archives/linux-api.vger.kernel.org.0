Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52D58E727F
	for <lists+linux-api@lfdr.de>; Mon, 28 Oct 2019 14:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388553AbfJ1NQY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Oct 2019 09:16:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43375 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388501AbfJ1NQY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Oct 2019 09:16:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id s4so10415682ljj.10
        for <linux-api@vger.kernel.org>; Mon, 28 Oct 2019 06:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RcPtv5d4Xhg7Yg5t5dc7cf1sdnUkFOizbhSvjAdERFI=;
        b=utV3o3aTqHm5KCIW69feKUGPuTsUaHcp/zpYcTzvlXi3Olyfe1n4hKAzlQ3gdcEU3p
         +QuGe8rjB2g0Q7BIO4DNZGZICNhpkadVJx6bhQNCcPFHCbbNxkbF8orYFak5554TAru/
         zMFayG+JhL2iTkDnZS3Ij6Xzb7NTBaWhtt+JCUB0Rwk/pt5gSDRIBDeaJ43vJywfeHAW
         SVXD2yhcM/0PInIsF3BvsDNaIHhqr3EAHAyEtdAxKawuv7fbhwNuNFOfPrC/zMa/xlJp
         RMwOt9XPvVBsYbuKzo3XnYLSDEEF3Q9ZhMMpv50JXGIKgrSy8rO2t6dogMuXPfXa0Yni
         l7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RcPtv5d4Xhg7Yg5t5dc7cf1sdnUkFOizbhSvjAdERFI=;
        b=BGDcJnTWMLvAsSddYO0SlQNo++K+wy3trw0n6AVQ2tPR8RT3Jmo5DErdyQgAQ/m791
         oBZBc8OvyFOyTPmX2arBh7ovVoGEgQzTbmHIlJkzB9DvGkbXCCBr3v7WlOkTp8MmdxHQ
         I8+nQsYTCMPg0vh3mW9EHLQDOl3j2UlsMTZjOKIQe1M6m6YHZCbJXycnZwyPW5RooTIv
         Nt19SGclCDSMMSyt5EXYF+0JoPGK+tRCpcqqynufmWy43S+yd1NVZBAJnG1h3isqM/JA
         dIk09794mp5w7EhWdJ8qLxMsKo2PtDhu8sIUCalVGtF3vGtZvS9cSx1day/qZb91hR5d
         vt0g==
X-Gm-Message-State: APjAAAUuwlFGBirGXF92TfHTF7F68zC1omfUkUHP6UMmWxAkyDEdpgNV
        DveU6l7ohHxwXDd0aBXXbOqKeQ==
X-Google-Smtp-Source: APXvYqyVfI0y1z4XXrCEM0pRrVCY4qmeS3CAaTSlq5hy1wZcRGDvnKux7ec6kYLSUeqeBO51XxbZtg==
X-Received: by 2002:a2e:924a:: with SMTP id v10mr11766000ljg.134.1572268582067;
        Mon, 28 Oct 2019 06:16:22 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y20sm8981461ljd.99.2019.10.28.06.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 06:16:21 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 23644100242; Mon, 28 Oct 2019 16:16:23 +0300 (+03)
Date:   Mon, 28 Oct 2019 16:16:23 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
Message-ID: <20191028131623.zwuwguhm4v4s5imh@box>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <1572171452-7958-2-git-send-email-rppt@kernel.org>
 <20191028123124.ogkk5ogjlamvwc2s@box>
 <20191028130018.GA7192@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028130018.GA7192@rapoport-lnx>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 28, 2019 at 02:00:19PM +0100, Mike Rapoport wrote:
> On Mon, Oct 28, 2019 at 03:31:24PM +0300, Kirill A. Shutemov wrote:
> > On Sun, Oct 27, 2019 at 12:17:32PM +0200, Mike Rapoport wrote:
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > 
> > > The mappings created with MAP_EXCLUSIVE are visible only in the context of
> > > the owning process and can be used by applications to store secret
> > > information that will not be visible not only to other processes but to the
> > > kernel as well.
> > > 
> > > The pages in these mappings are removed from the kernel direct map and
> > > marked with PG_user_exclusive flag. When the exclusive area is unmapped,
> > > the pages are mapped back into the direct map.
> > 
> > I probably blind, but I don't see where you manipulate direct map...
> 
> __get_user_pages() calls __set_page_user_exclusive() which in turn calls
> set_direct_map_invalid_noflush() that makes the page not present.

Ah. okay.

I think active use of this feature will lead to performance degradation of
the system with time.

Setting a single 4k page non-present in the direct mapping will require
splitting 2M or 1G page we usually map direct mapping with. And it's one
way road. We don't have any mechanism to map the memory with huge page
again after the application has freed the page.

It might be okay if all these pages cluster together, but I don't think we
have a way to achieve it easily.

-- 
 Kirill A. Shutemov
