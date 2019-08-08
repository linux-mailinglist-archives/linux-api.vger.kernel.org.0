Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB8286C12
	for <lists+linux-api@lfdr.de>; Thu,  8 Aug 2019 23:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbfHHVIZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 8 Aug 2019 17:08:25 -0400
Received: from smtp.infotech.no ([82.134.31.41]:51010 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732609AbfHHVIY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 8 Aug 2019 17:08:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id AA7D0204170;
        Thu,  8 Aug 2019 23:08:21 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Vk2dDO368jwk; Thu,  8 Aug 2019 23:08:21 +0200 (CEST)
Received: from [82.134.31.183] (unknown [82.134.31.183])
        by smtp.infotech.no (Postfix) with ESMTPA id 77FB4204154;
        Thu,  8 Aug 2019 23:08:21 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v3 00/20] sg: add v4 interface
To:     James Bottomley <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     martin.petersen@oracle.com, hare@suse.de, bvanassche@acm.org,
        Arnd Bergmann <arnd@arndb.de>,
        Tony Battersby <tonyb@cybernetics.com>
References: <20190807114252.2565-1-dgilbert@interlog.com>
 <1565291455.3435.48.camel@linux.vnet.ibm.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <7edab448-22cc-493a-f745-acc5be38f6a5@interlog.com>
Date:   Thu, 8 Aug 2019 23:08:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565291455.3435.48.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2019-08-08 9:10 p.m., James Bottomley wrote:
> On Wed, 2019-08-07 at 13:42 +0200, Douglas Gilbert wrote:
>> This patchset extends the SCSI generic (sg) driver found in
>> lk 5.3 .  The sg driver has a version number which is visible
>> via ioctl(SG_GET_VERSION_NUM) and is bumped from 3.5.36 to
>> 4.0.03 by this patchset. The additions and changes are
>> described in some detail in this long webpage:
>>      http://sg.danny.cz/sg/sg_v40.html
>>
>> Most new features described in the above webpage are not
>> implemented in this patchset.
> 
> Since this will be an extension of something that exists both in your
> sg driver and in the block bsg interface (and thus needs an
> implementation there), I added both linux-block and linux-api to the cc
> (the latter because you're adding to an API).

The SG_IO ioctl has been the synchronous SCSI pass-through interface
for over 15 years. Its quirk is that it takes two different formats
depending on the character device its file descriptor belongs to:
    - sg device file descriptor: sg v3 interface (struct sg_io_hdr)
    - bsg device file descriptor: sg v4 interface (struct sg_io_v4)

I'm only proposing one change in the synchronous interface based
on the SG_IO ioctl: to additionally accept the sg v4 interface in
the sg driver.

Arnd Bergmann considers two interface structures through one ioctl
as undesirable but is prepared to accept SG_IO. His POV is as the
maintainer of 32/64 bit compatibility ioctls. The case of SG_IO
is a well established exception to his rules (i.e. a known evil).

I don't believe extending ioctl SG_IO for asynchronous work is a
good idea. As pointed out above, it is already overloaded too
much. Additionally it would need further flags to differentiate
these cases:
    - sync/async
    - if async: submission or reception
    - and optionally if async: abort (an inflight request)
    - and do you want to add multiple requests in there too?

So are you looking at reducing the number of ioctl to the absolute
minimum? If so I don't think the SG_IO ioctl is the correct vehicle
for that. It doesn't use the _IOR(W) macros, instead it is hard
coded at 0x2285 ***. And the size checking offered by the _IOR(W)
macro (on the object pointed to by the 3rd argument) is useless with
SG_IO because it takes two different sized objects. Worse, one of
those objects changes size between 32 and 64 bits, while the other
does not.


Stepping back, this started about 18 months ago when security janitors
got upset about the bsg driver's use of write()/read() for its async
interface. Linus Torvalds suggested SG_IOSUBMIT and SG_IORECEIVE to
replace write() and read() respectively in bsg. Instead the write()/
read() interface was removed from the bsg driver. With it went the
ability to submit multiple requests in one write() call (by passing
an array of sg_io_v4 objects rather than just one). My intention is
to re-add that capability in the sg driver, using the ioctls that
Linus suggested.

Initially I had both the sg v3 and v4 interfaces passing through the
two ioctls. Arnd Bergmann preferred that a separate pair of ioctls
be used for each interface. Hence SG_IOSUBMIT_V3 and SG_IORECEIVE_V3
were added for the v3 interface. And thus SG_IOSUBMIT and SG_IORECEIVE
only use the v4 interface. This cleaned up my code and documentation.
As a bonus, all four ioctls use the _IORW macros and can check the
fixed size of the third argument to each ioctl invocation.


> Simply extending sg to use the v4 header protocol in uapi/linux/bsg.h
> is fine modulo the code being in the right form.  The problems are the
> new ioctls you want to add that would need to be present there as well.

Why? The bsg driver has never accepted the sg v3 interface. It has also
removed functionality that I'm trying to re-add in this, and a follow-on
patchset. The bsg driver has reduced its functionality as a generalized
SCSI pass-through, but it has more than enough other roles to justify
its existence, for example as a SMP (SAS) pass-through and a
driver/transport specific pass-through to various LLDs. I don't see the
need for the sg and bsg driver to move forward in lockstep.

>   The specific question being how we support async or non-blocking I/O
> on the sg and bsg interfaces.  The standard way we add asynchronous I/O
> is supposed to be via .poll on the file descriptor.  you already use
> read and write in sg and bsg doesn't have a polling interface,

It is hard to parse that last sentence; the sg driver has always
supported select/poll/epoll (and SIGIO plus RT signals). sg_poll()
will work just as well irrespective of whether a request is submitted
by write(), ioctl(SG_IOSUBMIT) or ioctl(SG_IOSUBMIT_V3).

  but it
> looks like we could use MSG to signal an ioctl is ready to be serviced
> for both.  Would shifting to a non-blocking poll based interface for
> ioctls remove the need to add these SG_IOSUBMIT/SG_IORECEIVE ioctls
> since we could now do everything over blocking or non-blocking SG_IO?

Not sure what the MSG is you refer to. The sg driver has had
ioctl(SG_GET_NUM_WAITING) for a long time. And it is made even
more lightweight in this patchset: it takes no locks, just reads one
atomic (a counter obviously) and returns. My guess is its faster the
select()/poll()/epoll() but doesn't have the ability to monitor
multiple file descriptors.

Here is the full set of extra ioctls I have, or will be proposing:
    SG_IOSUBMIT
    SG_IOSUBMIT_V3
    SG_IORECEIVE
    SG_IORECEIVE_V3
    SG_IOABORT
    SG_SG_SET_GET_EXTENDED

They are all new style ioctls using the _IOR(W) macros with fixed size
objects referenced by the ioctl's third argument. ioctls have been
referred to as the "garbage bin of Unix". Well that last one is a garbage
bin within a garbage bin :-) On the plus side, it keeps that list
relatively short.

Doug Gilbert


*** Tony Battersby is a sg driver power user. He has lamented wading through
     very large logs looking for some hint of why the sg driver is playing
     up. He has stated the strong preference for more, not less, ioctls.

BTW the write()/read() interface still remains in the sg driver after
these patchsets. It will continue to only support the sg v3 interface.
Perhaps calling it should cause a "deprecated" log message once for
each kernel run to annoy maintainers of old code.
