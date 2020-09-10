Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4360A2643C5
	for <lists+linux-api@lfdr.de>; Thu, 10 Sep 2020 12:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbgIJKVU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Sep 2020 06:21:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36589 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727893AbgIJKUq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Sep 2020 06:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599733242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
        bh=xiogVMZcF/3t6f2QYe0II+QsOuZb/cf7Ohd7CwObGpc=;
        b=RcMCKY5dboLLYqW49ki/mpTrpbKQzSOVjcJXo8nRrz2wQ68AOuF2M94QzIwXzUrPijIjsl
        4qU2j4gGytshLfblZjQwkfEDsSxvEtXdWOJGWkcrJnqgE+kviro0RPlDcjCkMHKn64QUJb
        0xmkXgUB+kKaXPRu+GVJevHYChNDRr0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-flWAhErEPxiTnxL7ZJ-TKw-1; Thu, 10 Sep 2020 06:20:39 -0400
X-MC-Unique: flWAhErEPxiTnxL7ZJ-TKw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA6A1802B6C;
        Thu, 10 Sep 2020 10:20:37 +0000 (UTC)
Received: from [10.36.113.88] (ovpn-113-88.ams2.redhat.com [10.36.113.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B97D25D9E8;
        Thu, 10 Sep 2020 10:20:35 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Subject: Ways to deprecate /sys/devices/system/memory/memoryX/phys_device ?
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-api@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <21852ccb-bd06-9281-7c8e-485ec02f2883@redhat.com>
Date:   Thu, 10 Sep 2020 12:20:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi everybody,

I was just exploring how /sys/devices/system/memory/memoryX/phys_device
is/was used. It's one of these interfaces that most probably never
should have been added but now we are stuck with it.

"phys_device" was used on s390x in older versions of lsmem[2]/chmem[3],
back when they were still part of s390x-tools. They were later replaced
[5] by the variants in linux-utils. For example, RHEL6 and RHEL7 contain
lsmem/chmem from s390-utils. RHEL8 switched to versions from util-linux
on s390x [4].

"phys_device" was added with sysfs support for memory hotplug in commit
3947be1969a9 ("[PATCH] memory hotplug: sysfs and add/remove functions")
in 2005. It always returned 0.

s390x started returning something != 0 on some setups (if sclp.rzm is
set by HW) in 2010 via commit 57b552ba0b2f("memory hotplug/s390: set
phys_device").

For s390x, it allowed for identifying which memory block devices belong
to the same memory increment (RZM). Only if all memory block devices
comprising a single memory increment were offline, the memory could
actually be removed in the hypervisor.

Since commit e5d709bb5fb7 ("s390/memory hotplug: provide
memory_block_size_bytes() function") in 2013 a memory block devices
spans at least one memory increment - which is why the interface isn't
really helpful/used anymore (except by old lsmem/chmem tools).

There were once RFC patches to make use of it in ACPI, but it could be
solved using different interfaces [1].


While I'd love to rip it out completely, I think it would break old
lsmem/chmem completely - and I assume that's not acceptable. I was
wondering what would be considered safe to do now/in the future:

1. Make it always return 0 (just as if "sclp.rzm" would be set to 0 on
s390x). This will make old lsmem/chmem behave differently after
switching to a new kernel, like if sclp.rzm would not be set by HW -
AFAIU, it will assume all memory is in a single memory increment. Do we
care?
2. Restrict it to s390x only. It always returned 0 on other
architectures, I was not able to find any user.

I think 2 should be safe to do (never used on other archs). I do wonder
what the feelings are about 1.

Thoughts?


[1] https://patchwork.kernel.org/patch/2163871/
[2] https://github.com/ibm-s390-tools/s390-tools/blob/v2.1.0/zconf/lsmem
[3] https://github.com/ibm-s390-tools/s390-tools/blob/v2.1.0/zconf/chmem
[4] https://bugzilla.redhat.com/show_bug.cgi?id=1504134
[5]
https://github.com/ibm-s390-tools/s390-tools/commit/778292e771fb00cfcbd7ff6535ee3d9fde612dc5#diff-82c32a7f4c597c50db90157ed0c581b3

-- 
Thanks,

David / dhildenb

