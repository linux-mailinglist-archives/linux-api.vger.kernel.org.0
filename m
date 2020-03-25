Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6142E193027
	for <lists+linux-api@lfdr.de>; Wed, 25 Mar 2020 19:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgCYSNA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Mar 2020 14:13:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34674 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYSNA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Mar 2020 14:13:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id 65so4450143wrl.1;
        Wed, 25 Mar 2020 11:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3QYyaGrQpYyWaZ6oYwhc56xJCsI+0fcYVeC22HIA+uc=;
        b=B1+oS4JxxUkN8An2JMtn4rbpXDh5oak3Nhzbu26gmN2zse3nygc/IXtxty0D4nLuej
         0QeZ4DLTCdNKczDxfBsuNLSD9qClbxxsLJ5aHJFscskDE1Y1ZmJdmpW/+2qSVRRZaicv
         S/Ih42cnymRQVZ6yU4OgBPZEtJhLI4bcqazrqrAKM/iM0WRDxdv+Ee2dxeCnq7AFFl7L
         037C5Y9HAQrMHdOxljt1hxOfO7i/ibEOeqGYj8vVWxWet88MhSoJPyg+XEQc8buXlpGN
         i8Ikon8CS3BDacMg4/IMbR5WHwfq72PeM9yhKAKXqCMvylgC/5JkvIBZQR1Y7SxraOMn
         rdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3QYyaGrQpYyWaZ6oYwhc56xJCsI+0fcYVeC22HIA+uc=;
        b=bOkj+jLUCCCq6eaLz9Ap3KRlNhcqaIxIpKKWrOTBvbXMlX8Y4UgWVKgeJuN7VchZDg
         bqgDWrCQ/rqlGbcToY+4VhJ2WgHp3kChWrgF2Vngh2TSPba5R4h5zUi73EfUeP4n3+O5
         Bg2AQAyPtmRxgtftImwslhayoa3z4dS9lxiOF5X3KS4AS0/Nbbtqaqmf6jzSV/65T5ER
         bJ+On1Ade11CwWPhjnj/VHP138oZohJYAXOcTnJpNTXp7vyzHw9AzNXKmZcG2FawrCob
         5XENeeMZeiCNSM0Y7V0GVM+85myHI+2cuia/dsZ9RSjE1OPVXo/qdDfjoyrF93+geZ26
         GdZg==
X-Gm-Message-State: ANhLgQ1J1oRjzEQwoAM9rt3d1jHIvo0vBJxfLU3uyeFrm7J5J2bq7z+Q
        /gGOMQSMJ24kKLkihB573g==
X-Google-Smtp-Source: ADFU+vsK87vWZ86CZbSOPvStWKiJYDwyDfB/k0nWBadKFPEKNE8HclBtYUpqZ807F5qMdQXCmPxW5Q==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr5033937wrp.403.1585159978286;
        Wed, 25 Mar 2020 11:12:58 -0700 (PDT)
Received: from avx2 ([46.53.251.45])
        by smtp.gmail.com with ESMTPSA id 71sm20166150wrc.53.2020.03.25.11.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 11:12:57 -0700 (PDT)
Date:   Wed, 25 Mar 2020 21:12:55 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     gregkh@linuxfoundation.org, leon@kernel.org, vbabka@suse.cz,
        akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, kasong@redhat.com,
        bhe@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, linux-api@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH v2 0/3] meminfo_extra: introduce meminfo extra
Message-ID: <20200325181255.GB18706@avx2>
References: <CGME20200323080507epcas1p44cdb9ecb70a7a7395b3acddeda3cfd89@epcas1p4.samsung.com>
 <20200323080503.6224-1-jaewon31.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200323080503.6224-1-jaewon31.kim@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 23, 2020 at 05:05:00PM +0900, Jaewon Kim wrote:
> /proc/meminfo or show_free_areas does not show full system wide memory
> usage status because memory stats do not track all memory allocations.
> There seems to be huge hidden memory especially on embedded system. It
> is because some HW IPs in the system use common DRAM memory instead of
> internal memory. Device drivers directly request huge pages from the
> page allocator with alloc_pages.
> 
> In Android system, most of those hidden memory seems to be vmalloc
> pages, ion system heap memory, graphics memory, and memory for DRAM
> based compressed swap storage. They may be shown in other node but it
> seems to be useful if /proc/meminfo_extra shows all those extra memory
> information. And show_mem also need to print the info in oom situation.
> 
> Fortunately vmalloc pages is already shown by commit 97105f0ab7b8
> ("mm: vmalloc: show number of vmalloc pages in /proc/meminfo"). Swap
> memory using zsmalloc can be seen through vmstat by commit 91537fee0013
> ("mm: add NR_ZSMALLOC to vmstat") but not on /proc/meminfo.
> 
> Memory usage of specific driver can be various so that showing the usage
> through upstream meminfo.c is not easy. To print the extra memory usage
> of a driver, introduce following APIs. Each driver needs to count as
> atomic_long_t.
> 
> int register_meminfo_extra(atomic_long_t *val, int shift,
> 			   const char *name);
> int unregister_meminfo_extra(atomic_long_t *val);
> 
> Currently register ION system heap allocator and zsmalloc pages.
> Additionally tested on local graphics driver.
> 
> i.e) cat /proc/meminfo_extra | tail -3
> IonSystemHeap:    242620 kB
> ZsPages:          203860 kB
> GraphicDriver:    196576 kB

In that case definitely delete ':', spaces and KB.
They only slowdown generation and parsing in userspace.
Values should be printed /proc/vmstat does it, maybe with tab instead of
space.

	foo	1234
	bar	0
	zot	111
