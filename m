Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F67E907DB
	for <lists+linux-api@lfdr.de>; Fri, 16 Aug 2019 20:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfHPSop (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Aug 2019 14:44:45 -0400
Received: from smtp.infotech.no ([82.134.31.41]:58942 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbfHPSop (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 16 Aug 2019 14:44:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 53F012042A1;
        Fri, 16 Aug 2019 20:44:42 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uI+AIVgJXuGD; Fri, 16 Aug 2019 20:44:40 +0200 (CEST)
Received: from [192.168.48.23] (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id EFDD020414F;
        Fri, 16 Aug 2019 20:44:38 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v3 00/20] sg: add v4 interface
To:     Bart Van Assche <bvanassche@acm.org>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     martin.petersen@oracle.com, hare@suse.de,
        Arnd Bergmann <arnd@arndb.de>,
        Tony Battersby <tonyb@cybernetics.com>,
        Christoph Hellwig <hch@lst.de>,
        Christian Franke <Christian.Franke@t-online.de>
References: <20190807114252.2565-1-dgilbert@interlog.com>
 <1565291455.3435.48.camel@linux.vnet.ibm.com>
 <7edab448-22cc-493a-f745-acc5be38f6a5@interlog.com>
 <1565305243.25619.27.camel@linux.vnet.ibm.com>
 <51e7cdfb-7921-9368-9b78-90ba5ac50c77@interlog.com>
 <6606add1-7ae7-5d8d-e660-d267164981d9@acm.org>
 <d0c60641-0607-a9c4-e79d-b6e850ef8682@interlog.com>
 <e25e6a74-4d54-3d91-d48d-ba9c91b2a874@acm.org>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <fcc2cbb3-92f2-ad37-fffe-ff2c77f8b2e1@interlog.com>
Date:   Fri, 16 Aug 2019 14:44:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e25e6a74-4d54-3d91-d48d-ba9c91b2a874@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2019-08-16 2:10 p.m., Bart Van Assche wrote:
> On 8/16/19 8:59 AM, Douglas Gilbert wrote:
>> On 2019-08-15 1:30 p.m., Bart Van Assche wrote:
>>> HSMR disks. What we need is the ability to discover, read, write and 
>>> configure such disks, support for the non-standard HSMR flex protocol, the 
>>> ability to give certain users or groups access to a subset of the LBAs and 
>>> also the ability to make that information persistent. I think that such 
>>> functionality could be implemented by extending LVM and by adding support for 
>>> all ZBC commands we need in the block layer, device mapper layer and also in 
>>> the asynchronous I/O layer. The block, dm and aio layers already support 
>>> submitting commands asynchronously but do not yet support all the ZBC 
>>> commands that we use.
>>
>> I believe that you will find that the more layers of abstraction that are
>> placed between the actual device and the OS level API, the more difficult
>> the discovery process will be. And in some cases you will need to get to
>> a management layer to let those management functions "pass-through" those
>> layers. Some RAID card drivers take advantage of the no_uld_attach flag in
>> scsi_device to expose real devices, but only to the sg/bsg interface for
>> management purposes (for utilities like smartmontools) and do not produce
>> sd device nodes.
> 
> Isn't the very purpose of an operating system to provide device drivers and 
> other abstraction layers such that not every application has to implement these?
> 
> My opinion is that using SG/IO to control SMR disks is suboptimal. A very 
> powerful feature of the Linux block layer is the ability to stack block drivers. 
> SG/IO is fundamentally incompatible with stacking block drivers. Stacking 
> requires having access to the LBA, request size and other block layer request 
> attributes. I don't think that we want to add code for parsing SCSI, NVMe 
> pass-through commands etc. in block drivers as the device mapper.
> 
> Hence my proposal to improve support in the block layer for ZBC instead of using 
> SG/IO to control SMR disks.

Please go right ahead. I just don't see why it should be at the expense
of this patchset or the sg pass-through in general.

Wearing another hat as the smartmontools SCSI maintainer, I know of no
supported OS or RAID product that has the infrastructure you talk about
for SMART information. The industry assumption seems to be that the
information will be pulled out at the real device level by a command set
pass-through. And RAID products present an issue if they don't support
a "no_uld_attach" type mechanism. The issue is that they then need to
offer a proprietary pass-through mechanism *** to bypass the virtual
device presented to the OS in order to get to the individual _real_
storage devices holding the SMART information. Sub-optimal maybe, but
still effective.

Doug Gilbert


*** and to their credit (IMO) several RAID "big boys" have sent the
     smartmontools project working code to navigate their proprietary
     pass-through mechanisms. Better that than us needing to beg for it.
