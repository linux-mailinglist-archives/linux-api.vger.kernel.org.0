Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E4F265D69
	for <lists+linux-api@lfdr.de>; Fri, 11 Sep 2020 12:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgIKKKE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Sep 2020 06:10:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29554 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725832AbgIKKKD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 Sep 2020 06:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599819001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=e0tIkR7loeaPe/OO5Nk7aLleyE/Pf/r3tN95GzFCd8U=;
        b=IIf/O6dSYUdKnntyGEj/2Ie0h9BgL+rxTgy76ux7AB2rvl/c42wWJYeXw2Fryp4wrQnaTS
        Eo8ndkiTEoK8wUFJpCdqO9sA6zoaQOBzQ3mZLSkfObIwlA9wqqgwO+0/ipjOiLWK353jjM
        EOfmlxLOVuupnP5g/sV4F/GY1b3LliI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-JdEcjZSOO2u-M5VC1OpMmA-1; Fri, 11 Sep 2020 06:09:57 -0400
X-MC-Unique: JdEcjZSOO2u-M5VC1OpMmA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BC0E18BA287;
        Fri, 11 Sep 2020 10:09:55 +0000 (UTC)
Received: from [10.36.113.186] (ovpn-113-186.ams2.redhat.com [10.36.113.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C1FF27BCC;
        Fri, 11 Sep 2020 10:09:52 +0000 (UTC)
Subject: Re: Ways to deprecate /sys/devices/system/memory/memoryX/phys_device
 ?
To:     Michal Hocko <mhocko@suse.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-api@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <f14f7f00-0501-bb93-88cc-780ae4fbaad3@intel.com>
 <3E00A442-7107-48DA-8172-EED95F6E1663@redhat.com>
 <20200911072035.GC7986@dhcp22.suse.cz>
 <02cdbf90-b29f-a9ec-c83d-49f2548e3e91@redhat.com>
 <20200911091252.GD7986@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 mQINBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABtCREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT6JAlgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63W5Ag0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAGJAjwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <0f532ff3-972b-bd91-30fe-1c3111d920bf@redhat.com>
Date:   Fri, 11 Sep 2020 12:09:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200911091252.GD7986@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11.09.20 11:12, Michal Hocko wrote:
> On Fri 11-09-20 10:09:07, David Hildenbrand wrote:
> [...]
>> Consider two cases:
>>
>> 1. Hot(un)plugging huge DIMMs: many (not all!) use cases want to
>> online/offline the whole thing. HW can effectively only plug/unplug the
>> whole thing. It makes sense in some (most?) setups to represent one DIMM
>> as one memory block device.
> 
> Yes, for the physical hotplug it doesn't really make much sense to me to
> offline portions that the HW cannot hotremove.

I've seen people offline parts of memory to simulate systems with less
RAM and people offline parts of memory on demand to save energy
(poweroff banks). People won't stop being creative with what we provided
to them :D

> 
>> 2. Hot(un)plugging small memory increments. This is mostly the case in
>> virtualized environments - especially hyper-v balloon, xen balloon,
>> virtio-mem and (drumroll) ppc dlpar and s390x standby memory. On PPC,
>> you want at least all (16MB!) memory block devices that can get
>> unplugged again individually ("LMBs") as separate memory blocks. Same on
>> s390x on memory increment size (currently effectively the memory block
>> size).
> 
> Yes I do recognize those usecase even though I will not pretend I
> consider it quesitonable. E.g. any hotplug with a smaller granularity
> than the memory model in Linus allows is just dubious. We simply cannot
> implement that without a lot of wasting and then the question is what is
> the real point.

Having the section size as small as possible in these environments is
most certainly preferable, to clean up metadata where possible.
Otherwise, hot(un)plugging smaller granularity behaves more like memory
ballooning (and I think I don't have to tell you that ballooning is used
excessively even though it wastes memory on metadata ;) ). Anyhow,
that's another discussion.

> 
>> In summary, larger memory block devices mostly only make sense with
>> DIMMs (and for boot memory in some cases). We will still end up with
>> many memory block devices in other configurations.
> 
> And that is fine because the boot time memory is still likely the
> primary source of memory. And reducing memory devices for those is a
> huge improvement already (just think of a multi TB system with
> gazillions pointless memory devices). 

Agreed. On my workstation (64GB - 4x16GB DIMMs if I recall correctly) I
end up with

$ cat /sys/devices/system/memory/block_size_bytes
8000000
$ ls /sys/devices/system/memory/ | grep memory | wc -l
512

$ cat /proc/iomem
00000000-00000fff : Reserved
00001000-0009ffff : System RAM
000a0000-000fffff : Reserved
  000a0000-000bffff : PCI Bus 0000:00
  000c0000-000dffff : PCI Bus 0000:00
    000c0000-000cf1ff : Video ROM
  000f0000-000fffff : System ROM
00100000-09dfffff : System RAM
09e00000-09ffffff : Reserved
0a000000-0a1fffff : System RAM
0a200000-0a20ffff : ACPI Non-volatile Storage
0a210000-b70fe017 : System RAM
b70fe018-b7117c57 : System RAM
b7117c58-b7118017 : System RAM
b7118018-b7129057 : System RAM
b7129058-b826cfff : System RAM
b826d000-b82c3fff : Reserved
b82c4000-b8d52fff : System RAM
b8d53000-b8d53fff : Reserved
b8d54000-bc67cfff : System RAM
bc67d000-bca26fff : Reserved
bca27000-bca73fff : ACPI Tables
bca74000-bd103fff : ACPI Non-volatile Storage
bd104000-bddfefff : Reserved
bddff000-beffffff : System RAM
bf000000-bfffffff : Reserved
[ PCI stuff ]
100000000-103f2fffff : System RAM
  d9f000000-d9fe00d90 : Kernel code
  da0000000-da07f9fff : Kernel rodata
  da0800000-da0a59e3f : Kernel data
  da110c000-da15fffff : Kernel bss
103f300000-10503fffff : Reserved


If we'd want to create a separate device during boot for each "System
RAM" resource, I am having a hard time figuring out the actual devices
(4 DIMMs). For memory hotplug it's a lot easier (e.g., separate
add_memory() calls). Of course, my workstation most probably doesn't
support DIMM hot(un)plug, so the BIOS might do strange things.

Also, I do wonder how hard the BIOS might mess up a DIMM configuration
(e820 map, resulting in "System RAM" resources) after hotplug, when
rebooting - or after kexec.

On bare metal, people expect that DIMMs that where hotplugged can be
hotunplugged again after reboot (of course, taking care of ZONE_MOVABLE,
which is a pain). As discussed under QEMU that's easier, because we get
separate add_memory() calls for all DIMMs from ACPI code. How stuff
behaves on bare metal is still a head-scratcher -  if we can rely on
separate "System RAM" instances to cover separate DIMMs, or if DIMMs
might get merged/split/EFI allocations ...

Maybe we can derive the actual DIMMs from some ACPI tables (SRAT?),
instead of relying on e820/"System RAM resources" - I have no clue.

>> I do agree that a "disable sysfs" option is interesting - even with
>> memory hotplug (we mostly need a way to configure it and a way to notify
>> kexec-tools about memory hot(un)plug events). I am currently (once
>> again) looking into improving auto-onlining support in the kernel.
>>
>> Having that said, I much rather want to see smaller improvements (that
>> can be fine-tuned individually - like allowing variable-sized memory
>> blocks) than doing a switch to "new shiny" and figuring out after a
>> while that we need "new shiny2".
> 
> There is only one certainty. Providing a long term interface with ever
> growing (ab)users is a hard target. And shinyN might be needed in the
> end. Who knows. My main point is that the existing interface is hitting
> a wall on usecases which _do_not_care_ about memory hotplug. And that is
> something we should be looking at.

Agreed. I can see 3 scenarios

a) no memory hotplug support, no sysfs.
b) memory hotplug support, no sysfs
c) memory hotplug support, sysfs

Starting with a) and c) is the easiest way to go.

> 
>> I consider removing "phys_device" as one of these tunables. The question
>> would be how to make such sysfs changes easy to configure
>> ("-phys_device", "+variable_sized_blocks" ...)
> 
> I am with you on that. There are more candidates in memory block
> directories which have dubious value. Deprecation process is a PITA and
> that's why I thought that it would make sense to focus on something that
> we can mis^Wdesign with exising and forming usecases in mind that would
> get rid of all the cruft that we know it doesn't work (removable would
> be another one.

Yeah, "phys_index" is also dubious. Simply providing a memory range
would have been much cleaner. Lesson learned :)

-- 
Thanks,

David / dhildenb

