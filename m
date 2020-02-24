Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93779169FD1
	for <lists+linux-api@lfdr.de>; Mon, 24 Feb 2020 09:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgBXIPy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Feb 2020 03:15:54 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32867 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBXIPx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 24 Feb 2020 03:15:53 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so9064568lji.0
        for <linux-api@vger.kernel.org>; Mon, 24 Feb 2020 00:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9E4atKHNFhMUgRRiEy/HKZbsazKIFq0A6zQaS+Ym2Rs=;
        b=0aRJ8jlk7K/HKTsns95GBBaEHmGtOdnFbjYj9vIhbo4+tLtlyfufBnVwleKPB1/X98
         Pgtv8FVCl9tXtLobT7bdmwNtDdZHepJTvYQCXdV9n1wLvHk+nzSJlzAmbOEH8mlNtA7v
         2DGluNg5tOwwERslMq2gB1V/ls4vsq6Q3436qFBbuOHbRKV974b0zOc/iXXNTzaB7r9u
         0Y+UxTJda51orCm8P6331EASksnvu6HLENq7I9WhIqKwFNvx+Aj7pHEwlDpT19zJbP6d
         hq9a+vogQGu+76vpLV9FQ94YnCrRP3OaxqfAj5NR7t5mEhqvtmmMD5AZ5LSwOYCEeT2G
         hHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9E4atKHNFhMUgRRiEy/HKZbsazKIFq0A6zQaS+Ym2Rs=;
        b=fOtvhoiYG2M4aocDKDkLwiiAwlkNW1Uc0UWYqtP1nZDW0A7/JbIYgJHrDp7ThyQGs/
         l0IStnaHf5HI9QDDJ9izyN58+OD4DsoBginmcVEAvB54PzNSEPEJ9Zq3w6lTXFXdp1SV
         nuPnSRDwmS+j/5cp7kjR7ja5nrM2TiTGYyHUQmAWfmoNFOdPh/jkxmMZ51KC6JT4tYzy
         ktTynj8wpZkg8m8AGFTuAhn4JxWRDRdiJZiBj7nENT40aH7N49WYTWTicXfEcukoVmhe
         pB8z5AZPPrjLU68Z4Y2XyROBPf5kkZG7tltLJ7AD3jXPEUMWQdiuoHK0Ka78cd+oTdj4
         uqBw==
X-Gm-Message-State: APjAAAV7dx00ZRyvg3rGrbAXgh9vt6TW5N5gNJkmOvkvdmYMdiRvirU5
        QPtWaVLIUGE6a/1SKLUs3uuChw==
X-Google-Smtp-Source: APXvYqzgh1ZGX/532+S4qeKBsp3fOZk0JQWUNLbURDxZxQbr4hjc1+mWNY2lYVuZyvgFoFMOCV92hw==
X-Received: by 2002:a2e:9b5a:: with SMTP id o26mr29929299ljj.190.1582532151395;
        Mon, 24 Feb 2020 00:15:51 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n189sm3008847lfa.14.2020.02.24.00.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 00:15:50 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id DF908100FD9; Mon, 24 Feb 2020 11:16:22 +0300 (+03)
Date:   Mon, 24 Feb 2020 11:16:22 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Florian Weimer <fweimer@redhat.com>, mtk.manpages@gmail.com,
        linux-man@vger.kernel.org, Lokesh Gidra <lokeshgidra@google.com>
Subject: Re: [PATCH v7 1/2] mm: Add MREMAP_DONTUNMAP to mremap().
Message-ID: <20200224081622.f4oy2pqk6aq6krfp@box>
References: <20200221174248.244748-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200221174248.244748-1-bgeffon@google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Feb 21, 2020 at 09:42:46AM -0800, Brian Geffon wrote:
> When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is
> set, the source mapping will not be removed. The remap operation
> will be performed as it would have been normally by moving over the
> page tables to the new mapping. The old vma will have any locked
> flags cleared, have no pagetables, and any userfaultfds that were
> watching that range will continue watching it.
> 
> For a mapping that is shared or not anonymous, MREMAP_DONTUNMAP will cause
> the mremap() call to fail. Because MREMAP_DONTUNMAP always results in moving
> a VMA you MUST use the MREMAP_MAYMOVE flag, it's not possible to resize
> a VMA while also moving with MREMAP_DONTUNMAP so old_len must always
> be equal to the new_len otherwise it will return -EINVAL.
> 
> We hope to use this in Chrome OS where with userfaultfd we could write
> an anonymous mapping to disk without having to STOP the process or worry
> about VMA permission changes.
> 
> This feature also has a use case in Android, Lokesh Gidra has said
> that "As part of using userfaultfd for GC, We'll have to move the physical
> pages of the java heap to a separate location. For this purpose mremap
> will be used. Without the MREMAP_DONTUNMAP flag, when I mremap the java
> heap, its virtual mapping will be removed as well. Therefore, we'll
> require performing mmap immediately after. This is not only time consuming
> but also opens a time window where a native thread may call mmap and
> reserve the java heap's address range for its own usage. This flag
> solves the problem."
> 
>   v6 -> v7:
>     - Don't allow resizing VMA as part of MREMAP_DONTUNMAP.
>       There is no clear use case at the moment and it can be added
>       later as it simplifies the implementation for now.
> 
>   v5 -> v6:
>     - Code cleanup suggested by Kirill.
> 
>   v4 -> v5:
>     - Correct commit message to more accurately reflect the behavior.
>     - Clear VM_LOCKED and VM_LOCKEDONFAULT on the old vma.
>            
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> Reviewed-by: Minchan Kim <minchan@kernel.org>
> Tested-by: Lokesh Gidra <lokeshgidra@google.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
