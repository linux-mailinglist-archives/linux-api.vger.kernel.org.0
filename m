Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3B19051B
	for <lists+linux-api@lfdr.de>; Fri, 16 Aug 2019 17:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfHPP7L (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Aug 2019 11:59:11 -0400
Received: from smtp.infotech.no ([82.134.31.41]:58765 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbfHPP7L (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 16 Aug 2019 11:59:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 1943A2042A1;
        Fri, 16 Aug 2019 17:59:08 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gYniUMtMdR9j; Fri, 16 Aug 2019 17:59:06 +0200 (CEST)
Received: from [192.168.48.23] (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id 96F3B20418E;
        Fri, 16 Aug 2019 17:59:04 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v3 00/20] sg: add v4 interface
To:     Bart Van Assche <bvanassche@acm.org>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     martin.petersen@oracle.com, hare@suse.de,
        Arnd Bergmann <arnd@arndb.de>,
        Tony Battersby <tonyb@cybernetics.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190807114252.2565-1-dgilbert@interlog.com>
 <1565291455.3435.48.camel@linux.vnet.ibm.com>
 <7edab448-22cc-493a-f745-acc5be38f6a5@interlog.com>
 <1565305243.25619.27.camel@linux.vnet.ibm.com>
 <51e7cdfb-7921-9368-9b78-90ba5ac50c77@interlog.com>
 <6606add1-7ae7-5d8d-e660-d267164981d9@acm.org>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <d0c60641-0607-a9c4-e79d-b6e850ef8682@interlog.com>
Date:   Fri, 16 Aug 2019 11:59:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6606add1-7ae7-5d8d-e660-d267164981d9@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2019-08-15 1:30 p.m., Bart Van Assche wrote:
> On 8/13/19 9:19 PM, Douglas Gilbert wrote:
>> Bart Van Assche hinted at a better API design but didn't present
>> it. If he did, that would be the first time an alternate API
>> design was presented for async usage in the 20 years that I have
>> been associated with the driver.
> 
> I would like to start from the use cases instead of the implementation of a new 
> SG/IO interface. My employer uses the SG/IO interface for controlling SMR and 

There is no "new" SG/IO interface. Linux has broken the ability of char
drivers to safely use the read() and write() system calls. This
adversely impacts the bsg and sg drivers. In response the following
replacement mappings have been suggested in my first sg patchset:

1) For sg driver currently in production, its async interface:
        write(sg_fd, &sg_v3_obj, sizeof(sg_v3_obj))
          ----->  ioctl(sg_fd, SG_IOSUBMIT_V3, &sg_v3_obj)
    and
        read(sg_fd, &sg_v3_obj, sizeof(sg_v3_obj))
          ----->  ioctl(sg_fd, SG_RECEIVE_V3, &sg_v3_obj)

    And send out a WARN_ONCE when write(sg_fd, &sg_v3_obj,...) is used.

2) For the async portion of the bsg driver that was removed last
    year, the following, slightly more complex mapping is proposed:
        write(bsg_fd, &sg_v4_obj, sizeof(sg_v4_obj))
          ----->  ioctl(sg_fd_equiv_bsg, SG_IOSUBMIT, &sg_v4_obj)
    and
        read(bsg_fd, &sg_v4_obj, sizeof(sg_v4_obj))
          ----->  ioctl(sg_fd_equiv_bsg, SG_RECEIVE, &sg_v4_obj)

    The bsg_fd --> sg_fd_equiv_bsg mapping can be done with the help
    of sysfs.


There is another case with the bsg async interface where the third
argument to write() and read() is a multiple of the size of a sg_v4_obj.
I call that a multiple requests invocation. That is handled in my second
patchset with an extra level of indirection. Yes, that is a change in
the API, but it is more on the syntax side rather than the semantics side.

The ioctls have another advantage over the write()/read() interface.
The reader will notice the both SG_IOSUBMIT and SG_IORECEIVE are defined
with the _IOWR() macro indicating bi-directional dataflow. The "reverse"
direction dataflow for the submit side is when a tag is sent back from
the block layer. For the receive side the reverse flow is when matching
either by pack_id or tag.

Also some longstanding features of the sg async API such as
ioctl(SG_GET_NUM_WAITING) can lead to a reduction in API traffic. Say
we have 20 SCSI commands that don't depend on one another (e.g. READ
GATHERED). They could be submitted asynchronously with a single
multiple requests invocation by ioctl(SG_IOSUBMIT) with the flag
SGV4_FLAG_IMMED set. The user code could then wait for one (any one)
to finish and process it (so that is two API calls so far). Now an
ioctl(SG_GET_NUM_WAITING) could be issued and say it gets 3 then a
multiple requests invocation of ioctl(SG_IORECEIVE) for those 3
could be sent and complete promptly. Now the tally of API calls is
up to 4. If another ioctl(SG_GET_NUM_WAITING) was issued and say
it yielded 16 then a multiple requests invocation of
ioctl(SG_IORECEIVE) for those 16 would complete the originally
submitted 20 SCSI commands. The total tally of API calls is 6 with
only 1 of those waiting. The wait could be made fully async by
using a polling loop or a signal to replace that (and any other)
wait.

If the user space didn't mind blocking then the whole 20 SCSI commands
could be processed efficiently with a single multiple requests
invocation using ioctl(SG_IOSUBMIT) with the SGV4_FLAG_IMMED flag
cleared. It would first issue all 20 command then return after all 20
commands were complete. That is an extension of the removed bsg async
SCSI API, but a pretty good one IMO.

The sg driver's async model remains basically the same as when the
driver first appeared in 1992. Naturally there have been enhancements
along the way, such as that last example.

> HSMR disks. What we need is the ability to discover, read, write and configure 
> such disks, support for the non-standard HSMR flex protocol, the ability to give 
> certain users or groups access to a subset of the LBAs and also the ability to 
> make that information persistent. I think that such functionality could be 
> implemented by extending LVM and by adding support for all ZBC commands we need 
> in the block layer, device mapper layer and also in the asynchronous I/O layer. 
> The block, dm and aio layers already support submitting commands asynchronously 
> but do not yet support all the ZBC commands that we use.

I believe that you will find that the more layers of abstraction that are
placed between the actual device and the OS level API, the more difficult
the discovery process will be. And in some cases you will need to get to
a management layer to let those management functions "pass-through" those
layers. Some RAID card drivers take advantage of the no_uld_attach flag in
scsi_device to expose real devices, but only to the sg/bsg interface for
management purposes (for utilities like smartmontools) and do not produce
sd device nodes.

> Are there any SG/IO use cases that have not yet been mentioned in this e-mail 
> thread? If SMR and HSMR are the primary use cases for SG/IO, should asynchronous 
> command support be added in the SG/IO layer or should rather ZBC support in the 
> block, dm and aio layers be improved?

My guess is quite a few, and the companies involved don't want to talk about
their use publicly. For example when a big computer company starts reporting
errors, I believe my role is to try and fix the errors, not to interrogate
them about how and why they are using the driver. On the other hand, Tony
Battersby has been relatively active on this list and produced patches for
the sg driver over several years. Tony is well positioned to know the
driver's  strengths and weaknesses but has said that he has little time to
review these patchsets. I appreciate any feedback I can get from him.

Doug Gilbert


