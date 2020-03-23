Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D70918F095
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2020 09:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgCWIFP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Mar 2020 04:05:15 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:50982 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbgCWIFO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 23 Mar 2020 04:05:14 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200323080510epoutp0219ee5c0b8130804e2866b9430331c4e4~_4EYV6UVd3028630286epoutp02p
        for <linux-api@vger.kernel.org>; Mon, 23 Mar 2020 08:05:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200323080510epoutp0219ee5c0b8130804e2866b9430331c4e4~_4EYV6UVd3028630286epoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584950710;
        bh=P4CavwZXkNCT7Ikw0Fe20I2u/uDn4BTxVIDGmLZRxuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UcEXFM2WTcTtblyK758mlzUNgO3piXC6/70tFii6H5/ufSCHx6oWpXlZLJlgbZoNG
         eVTjUqrc/dY3OsBESsu2TKTg/xk0l5sECj+0r4xbwQpPd5+9ZvNYi+7VUZmOMCMsd/
         f/+51c541VgWwscBiShDwttLL95ifxl8Q39Ii10Q=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200323080509epcas1p188e0bb9b7848da53225cb7f3c86ec8ae~_4EXouD5b0465004650epcas1p1q;
        Mon, 23 Mar 2020 08:05:09 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.162]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 48m6PJ5KSCzMqYl0; Mon, 23 Mar
        2020 08:05:08 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.0E.04160.4BD687E5; Mon, 23 Mar 2020 17:05:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200323080508epcas1p3c68190cd46635b9ff026a4ae70fc7a3b~_4EWPvhKj3019030190epcas1p3D;
        Mon, 23 Mar 2020 08:05:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200323080508epsmtrp1b7b626fbe636fd09f4fa64c04c8276d1~_4EWO2m150107001070epsmtrp1-;
        Mon, 23 Mar 2020 08:05:08 +0000 (GMT)
X-AuditID: b6c32a38-297ff70000001040-11-5e786db41e39
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.73.04024.4BD687E5; Mon, 23 Mar 2020 17:05:08 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200323080508epsmtip1996987f173182e8893721e72705829c8~_4EWBdNZ70114401144epsmtip1O;
        Mon, 23 Mar 2020 08:05:08 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     gregkh@linuxfoundation.org, leon@kernel.org, vbabka@suse.cz,
        adobriyan@gmail.com, akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, kasong@redhat.com,
        bhe@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, linux-api@vger.kernel.org,
        kexec@lists.infradead.org, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [RFC PATCH v2 3/3] android: ion: include system heap size in
 meminfo extra
Date:   Mon, 23 Mar 2020 17:05:03 +0900
Message-Id: <20200323080503.6224-4-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200323080503.6224-1-jaewon31.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCJsWRmVeSWpSXmKPExsWy7bCmru6W3Io4g/sz1C2mN3pZzFm/hs3i
        /INfbBbNi9ezWXRvnslo0fv+FZPF8nenGS12n/7KZLFyzw8miym/ljJbbP7ewWZxedccNot7
        a/6zWiz7+p7dYkPLLHaLRxMmMVmcuvuZ3WJ2Yx+jg5DHzll32T02repk89j0aRK7x51re9g8
        Tsz4zeKxf+4ado/NS+o93u+7yubRt2UVo8eZBUfYPXZ+2szq8XmTXABPVI5NRmpiSmqRQmpe
        cn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtB7SgpliTmlQKGAxOJiJX07
        m6L80pJUhYz84hJbpdSClJwCQ4MCveLE3OLSvHS95PxcK0MDAyNToMqEnIwrT6czFlwQrZh8
        /S5rA+NCoS5GTg4JAROJT1emMYPYQgI7GCVuLiroYuQCsj8xSmzf+oUJwvnGKPF4ykVWmI6P
        1zZAJfYySrzaeJ4dov07o8T+9lIQm01AW+L9gkmsIEUiAv1MEovuLmIBcZgF1jJKrOq6ywRS
        JSwQKnFp5iUWEJtFQFVi8oaZYDavgI3EisuTgWwOoHXyEgv/g93HKWArse/SLTaQORICi9gl
        LmyYxQZxkovE8afzGSFsYYlXx7ewQ9hSEi/729ghGpoZJd7O3MwI4bQwStzd1AvVYSzR23OB
        GWQbs4CmxPpd+hBhRYmdv+eClTAL8Em8+9rDCnEQr0RHGzTw1CRann2FBouMxN9/z6BsD4kF
        89+xQoJoAqPEoZsvWScwys1C2LCAkXEVo1hqQXFuemqxYYEJcpxtYgSnYC2LHYx7zvkcYhTg
        YFTi4b3RWx4nxJpYVlyZe4hRgoNZSYR3c2pFnBBvSmJlVWpRfnxRaU5q8SFGU2BQTmSWEk3O
        B+aHvJJ4Q1MjY2NjCxMzczNTYyVx3qnXc+KEBNITS1KzU1MLUotg+pg4OKUaGMWv2NjONrv7
        o9X3Mkcn5zvFf5tS/Ha1t+v8c5Y771wTPqVj0vuaN2tzmk65pD1+YWG65KLGrn1xMtz8eQxr
        zivsZl9qXzT9xhy7ywIsEn33X0euFkvaFjS7SDh4xd7nogGR7eWnFJ/whrueWV14WC1X/1XD
        7avnLJ4ERidLngy4abm401ZvpxJLcUaioRZzUXEiAPhoS1HXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSnO6W3Io4g1m7OC2mN3pZzFm/hs3i
        /INfbBbNi9ezWXRvnslo0fv+FZPF8nenGS12n/7KZLFyzw8miym/ljJbbP7ewWZxedccNot7
        a/6zWiz7+p7dYkPLLHaLRxMmMVmcuvuZ3WJ2Yx+jg5DHzll32T02repk89j0aRK7x51re9g8
        Tsz4zeKxf+4ado/NS+o93u+7yubRt2UVo8eZBUfYPXZ+2szq8XmTXABPFJdNSmpOZllqkb5d
        AlfGlafTGQsuiFZMvn6XtYFxoVAXIyeHhICJxMdrG5i6GLk4hAR2M0r0LexghkjISLw5/5Sl
        i5EDyBaWOHy4GKLmK6PEul0/WUFq2AS0Jd4vmARmiwjMZ5Lob+cHKWIW2MwoMXFpMwtIQlgg
        WGLu8X2MIDaLgKrE5A0zweK8AjYSKy5PhlogL7HwP9heTgFbiX2XbrGB2EJAJVu7nzFPYORb
        wMiwilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOEq0NHcwXl4Sf4hRgINRiYf3Rm95
        nBBrYllxZe4hRgkOZiUR3s2pFXFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZ/mHYsUEkhPLEnN
        Tk0tSC2CyTJxcEo1MBovOqR8+WWsncxxd1+XvQYMhcK/OQ4+vlhzaWPopNxSkaqt56vep2aX
        POpNsr76QvGH0NJ/L/oks54niubs/J/y6PnsJGbhw7Gtui6XxJQfL+r/2Zl+LzwlxD/h7Nen
        M3gWibzpKPFeM0eWqYp3B+fDW1msS58kiLStmaDRLzNhsthi0b+sv5VYijMSDbWYi4oTAT2/
        SM2OAgAA
X-CMS-MailID: 20200323080508epcas1p3c68190cd46635b9ff026a4ae70fc7a3b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200323080508epcas1p3c68190cd46635b9ff026a4ae70fc7a3b
References: <20200323080503.6224-1-jaewon31.kim@samsung.com>
        <CGME20200323080508epcas1p3c68190cd46635b9ff026a4ae70fc7a3b@epcas1p3.samsung.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

In Android system ion system heap size is huge like hundreds of MB. To
know overal system memory usage, include ion system heap size in
proc/meminfo_extra.

To include heap size, use register_meminfo_extra introduced in previous
patch.

Prior to register we need to add stats to show the ion heap usage. Add
total_allocated into ion heap and count it on allocation and freeing. In
a ion heap using ION_HEAP_FLAG_DEFER_FREE, a buffer can be freed from
user but still live on deferred free list. Keep stats until the buffer
is finally freed so that we can cover situation of deferred free thread
stuck problem.

i.e) cat /proc/meminfo_extra | grep IonSystemHeap
IonSystemHeap:    242620 kB

i.e.) show_mem on oom
<6>[  420.856428]  Mem-Info:
<6>[  420.856433]  IonSystemHeap:32813kB

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 drivers/staging/android/ion/ion.c             | 2 ++
 drivers/staging/android/ion/ion.h             | 1 +
 drivers/staging/android/ion/ion_system_heap.c | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 38b51eace4f9..76db91a9f26a 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -74,6 +74,7 @@ static struct ion_buffer *ion_buffer_create(struct ion_heap *heap,
 
 	INIT_LIST_HEAD(&buffer->attachments);
 	mutex_init(&buffer->lock);
+	atomic_long_add(len, &heap->total_allocated);
 	return buffer;
 
 err1:
@@ -95,6 +96,7 @@ void ion_buffer_destroy(struct ion_buffer *buffer)
 	buffer->heap->num_of_buffers--;
 	buffer->heap->num_of_alloc_bytes -= buffer->size;
 	spin_unlock(&buffer->heap->stat_lock);
+	atomic_long_sub(buffer->size, &buffer->heap->total_allocated);
 
 	kfree(buffer);
 }
diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
index 74914a266e25..10867a2e5728 100644
--- a/drivers/staging/android/ion/ion.h
+++ b/drivers/staging/android/ion/ion.h
@@ -157,6 +157,7 @@ struct ion_heap {
 	u64 num_of_buffers;
 	u64 num_of_alloc_bytes;
 	u64 alloc_bytes_wm;
+	atomic_long_t total_allocated;
 
 	/* protect heap statistics */
 	spinlock_t stat_lock;
diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index b83a1d16bd89..f7882fb7505d 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -259,6 +259,8 @@ static struct ion_heap *__ion_system_heap_create(void)
 	if (ion_system_heap_create_pools(heap->pools))
 		goto free_heap;
 
+	register_meminfo_extra(&heap->heap.total_allocated, PAGE_SHIFT,
+			       "IonSystemHeap");
 	return &heap->heap;
 
 free_heap:
-- 
2.13.7

