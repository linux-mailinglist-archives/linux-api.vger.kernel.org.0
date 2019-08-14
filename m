Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3A3E8CA2D
	for <lists+linux-api@lfdr.de>; Wed, 14 Aug 2019 06:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbfHNEUJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Aug 2019 00:20:09 -0400
Received: from smtp.infotech.no ([82.134.31.41]:44022 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725263AbfHNEUI (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 14 Aug 2019 00:20:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 7CB2B20423A;
        Wed, 14 Aug 2019 06:20:05 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iLhfFv5AlQcz; Wed, 14 Aug 2019 06:20:02 +0200 (CEST)
Received: from [192.168.48.23] (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id A93D820414F;
        Wed, 14 Aug 2019 06:20:00 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
Subject: Re: [PATCH v3 00/20] sg: add v4 interface
Reply-To: dgilbert@interlog.com
To:     James Bottomley <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     martin.petersen@oracle.com, hare@suse.de, bvanassche@acm.org,
        Arnd Bergmann <arnd@arndb.de>,
        Tony Battersby <tonyb@cybernetics.com>
References: <20190807114252.2565-1-dgilbert@interlog.com>
 <1565291455.3435.48.camel@linux.vnet.ibm.com>
 <7edab448-22cc-493a-f745-acc5be38f6a5@interlog.com>
 <1565305243.25619.27.camel@linux.vnet.ibm.com>
Message-ID: <51e7cdfb-7921-9368-9b78-90ba5ac50c77@interlog.com>
Date:   Wed, 14 Aug 2019 00:19:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565305243.25619.27.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2019-08-09 1:00 a.m., James Bottomley wrote:
> On Thu, 2019-08-08 at 23:08 +0200, Douglas Gilbert wrote:
>> On 2019-08-08 9:10 p.m., James Bottomley wrote:
>>> On Wed, 2019-08-07 at 13:42 +0200, Douglas Gilbert wrote:
>>>> This patchset extends the SCSI generic (sg) driver found in
>>>> lk 5.3 .  The sg driver has a version number which is visible
>>>> via ioctl(SG_GET_VERSION_NUM) and is bumped from 3.5.36 to
>>>> 4.0.03 by this patchset. The additions and changes are
>>>> described in some detail in this long webpage:
>>>>       http://sg.danny.cz/sg/sg_v40.html
>>>>
>>>> Most new features described in the above webpage are not
>>>> implemented in this patchset.
>>>
>>> Since this will be an extension of something that exists both in
>>> your sg driver and in the block bsg interface (and thus needs an
>>> implementation there), I added both linux-block and linux-api to
>>> the cc (the latter because you're adding to an API).
>>
>> The SG_IO ioctl has been the synchronous SCSI pass-through interface
>> for over 15 years. Its quirk is that it takes two different formats
>> depending on the character device its file descriptor belongs to:
>>      - sg device file descriptor: sg v3 interface (struct sg_io_hdr)
>>      - bsg device file descriptor: sg v4 interface (struct sg_io_v4)
>>
>> I'm only proposing one change in the synchronous interface based
>> on the SG_IO ioctl: to additionally accept the sg v4 interface in
>> the sg driver.
> 
> Right, as I said below, adding v4 to sg looks to be fine.  We don't
> need v3 in BSG since v4 is a superset.
> 
>> Arnd Bergmann considers two interface structures through one ioctl
>> as undesirable but is prepared to accept SG_IO. His POV is as the
>> maintainer of 32/64 bit compatibility ioctls. The case of SG_IO
>> is a well established exception to his rules (i.e. a known evil).
>>
>> I don't believe extending ioctl SG_IO for asynchronous work is a
>> good idea. As pointed out above, it is already overloaded too
>> much. Additionally it would need further flags to differentiate
>> these cases:
>>      - sync/async
>>      - if async: submission or reception
>>      - and optionally if async: abort (an inflight request)
>>      - and do you want to add multiple requests in there too?
>>
>> So are you looking at reducing the number of ioctl to the absolute
>> minimum? If so I don't think the SG_IO ioctl is the correct vehicle
>> for that. It doesn't use the _IOR(W) macros, instead it is hard
>> coded at 0x2285 ***. And the size checking offered by the _IOR(W)
>> macro (on the object pointed to by the 3rd argument) is useless with
>> SG_IO because it takes two different sized objects. Worse, one of
>> those objects changes size between 32 and 64 bits, while the other
>> does not.
> 
> OK, so this is where interface design is important.  It's perfectly
> possible to design an async interface using the current v4 BSG SG_IO.
> You simply open the device O_NONBLOCK and send the ioctl which will
> return immediately.  To find out when it returns you poll (we'd
> obviously need to add polling in bsg, but that's fairly simple).  Since
>   poll/select/epoll is our standard async event handling mechanism, we
> should at least try it and have a good reason why it doesn't work
> before inventing our own equivalent.

I don't see much new interface design here over what was done by
Lawrence Foard 27 years ago. Linux cleverness has broken the
classic use of read() and write() in char drivers. Hard to hold that
against the original design. The design works if the last 27 years
is any guide and maps reasonably closely to how the mid-level
(or the block layer) issues SCSI commands. All other general
purpose OSes that I am aware of, with the exception of Darwin,
have a similar SCSI pass-through, at least on the sync side.

>> Stepping back, this started about 18 months ago when security
>> janitors got upset about the bsg driver's use of write()/read() for
>> its async interface. Linus Torvalds suggested SG_IOSUBMIT and
>> SG_IORECEIVE to replace write() and read() respectively in bsg.
>> Instead the write()/read() interface was removed from the bsg driver.
>> With it went the ability to submit multiple requests in one write()
>> call (by passing an array of sg_io_v4 objects rather than just one).
>> My intention is to re-add that capability in the sg driver, using the
>> ioctls that Linus suggested.
> 
> What I'm saying is let's discuss the interface design before we add it.
>   the submit/receive interface is essentially a packet one.  The problem
> with a packet one is that we're request/response where the response
> likely altered some user memory area, so each response has to be
> matched with the outbound request to find out what happened ... how is
> that done?

Well this has been fundamental to the sg driver design. There are
now three mechanisms, described below with the oldest first:
   1) pack_id: an identifying integer supplied by the user in the
      submit that can be given as input to the receive call so
      it either yields the (first) matching response, or waits (sync
      action) or returns saying nothing was found (async action).
      pack_id was present in the sg driver in version 1.0 of Linux
      in 1992. It still works fine.
   2) usr_ptr: sometimes described as a "closure pointer". User
      provided, untouched by the driver, and placed in the
      corresponding response. Present in sg v3 and v4 interfaces.
      In place over 15 years.
   3) tag: like pack_id but issued by the block layer so it is
      _output_ by the submit call. In practice it does not work
      reliably *** due to questionable design in the block layer. After
      blk_execute_rq_nowait() is called the tag is picked out of
      its data structure. However that command may not have started
      (so no valid tag) or could have already finished (a stale tag).
      Tag is a new feature in the proposed patchsets.

> One way to do it simply with existing SG_IO is to allow only one
> outstanding request per FD, so if you want five requests, you open five
> FDs and then poll all of them to see which one returns.  I'm not saying
> it's the best because FDs are a somewhat precious commodity, but it is
> possible and it's a simple extension of what exists today.

I believe this is adequately covered by the mechanisms above.

>> Initially I had both the sg v3 and v4 interfaces passing through the
>> two ioctls. Arnd Bergmann preferred that a separate pair of ioctls
>> be used for each interface. Hence SG_IOSUBMIT_V3 and SG_IORECEIVE_V3
>> were added for the v3 interface. And thus SG_IOSUBMIT and
>> SG_IORECEIVE only use the v4 interface. This cleaned up my code and
>> documentation. As a bonus, all four ioctls use the _IORW macros and
>> can check the fixed size of the third argument to each ioctl
>> invocation.
> 
> Can we talk first about how the interface should work.  We can get into
> assigning ioctls and what extensions are needed later.

I have been trying for 9 months to get some feedback on
the current design. The attitude seems to be present some
patches; no, those ones are too big, etc. As for my design
document at:
     http://sg.danny.cz/sg/sg_v40.html

tl;dr ?

Evidently write() and read() system calls have special features
that could be exploited by an attack via the bsg or sg drivers.
ioctl(SG_IOSUBMIT) is just write(sg_fd, ...) that is less
exploitable. There is a similar relationship between
ioctl(SG_IORECEIVE) an read(sg_fd, ...). Otherwise the async
interface design remains the same in the sg driver as it was
when introduced 27 years ago. ^^^

Bart Van Assche hinted at a better API design but didn't present
it. If he did, that would be the first time an alternate API
design was presented for async usage in the 20 years that I have
been associated with the driver.

>>> Simply extending sg to use the v4 header protocol in
>>> uapi/linux/bsg.h is fine modulo the code being in the right
>>> form.  The problems are the new ioctls you want to add that would
>>> need to be present there as well.
>>
>> Why? The bsg driver has never accepted the sg v3 interface. It has
>> also removed functionality that I'm trying to re-add in this, and a
>> follow-on patchset. The bsg driver has reduced its functionality as a
>> generalized SCSI pass-through, but it has more than enough other
>> roles to justify its existence, for example as a SMP (SAS) pass-
>> through and a driver/transport specific pass-through to various LLDs.
>> I don't see the need for the sg and bsg driver to move forward in
>> lockstep.
> 
> You quote Linus a lot above, but he also said "I wonder if we could at

twice

> least try to unify the bsg/sg code - possibly by making sg use the
> prettier bsg code (but definitely have to add all the security
> measures)".  It's in the interests of unity that we need to make the
> code paths look the same as possible, so eventually one could call the
> other.  ideally sg would call bsg for v4 and we'd add async to bsg so
> it would work for both.

The bsg driver needs to be rewritten. Ah, no need since by removing the
async (including multiple requests) part, the broken implementation is
no more. Its implementation is sufficient to issue synchronous
SCSI commands, not much more +++. The bsg v4 interface implementation
was only a superset of the sg driver's v3 interface while the Linux
kernel supported bidi. That has unwisely been (completely) removed
from the kernel. So now I would regard the bsg v4 implementation
as a subset of the functionality in the sg v3 implementation which
itself is a subset of the proposed sg v4 implementation. So I see
no reason to use the bsg v4 implementation or handicap the proposed
sg v4 implementation.

>>>    The specific question being how we support async or non-blocking
>>> I/O on the sg and bsg interfaces.  The standard way we add
>>> asynchronous I/O is supposed to be via .poll on the file
>>> descriptor.  you already use read and write in sg and bsg doesn't
>>> have a polling interface,
>>
>> It is hard to parse that last sentence; the sg driver has always
>> supported select/poll/epoll (and SIGIO plus RT signals). sg_poll()
>> will work just as well irrespective of whether a request is submitted
>> by write(), ioctl(SG_IOSUBMIT) or ioctl(SG_IOSUBMIT_V3).
> 
> The way I read how the interface works, it only works when the fd is
> ready for read (i.e. a packet submitted with read has returned).  We
> need to extend it to make it work with ioctl.  Since ioctl returns
> isn't either a 'ready to read' or 'ready to write' event on the fd I
> was suggesting using 'msg ready' event for it.

A ready response causes a POLL_IN event. POLL_OUT is only cleared when
the command queueing on a fd is turned off and a request is inflight or
awaiting a ioctl(SG_IORECEIVE) (a.k.a. read()). So the existing POLL
events map quite well. As a bonus, if there is a surprise removal of
a sg device, then a SIG_HUP is generated.

As I noted, if an app doesn't need to monitor multiple file
descriptors, then ioctl(SG_GET_NUM_WAITING) is an option. It been in
place for 20 years and is sped up by this patchset. I clocked it at
500 nanoconds per call (i.e. 2 million could be issued in one thread
in 1 second) on my laptop. And since you then find out how many are
waiting to be processed, the user could issue a multiple requests
ioctl(SG_IORECEIVE) and pick them all up in one system call invocation.

>>> but it looks like we could use MSG to signal an ioctl is ready to
>>> be serviced for both.  Would shifting to a non-blocking poll based
>>> interface for ioctls remove the need to add these
>>> SG_IOSUBMIT/SG_IORECEIVE ioctls since we could now do everything
>>> over blocking or non-blocking SG_IO?
>>
>> Not sure what the MSG is you refer to. The sg driver has had
>> ioctl(SG_GET_NUM_WAITING) for a long time. And it is made even
>> more lightweight in this patchset: it takes no locks, just reads one
>> atomic (a counter obviously) and returns. My guess is its faster the
>> select()/poll()/epoll() but doesn't have the ability to monitor
>> multiple file descriptors.
> 
> the poll interfaces don't tell you how many outstanding request you
> have, they tell you when some event happened on the fd.  The event
> we're looking for with async packets is an indication of what
> completed.

As well as ioctl(SG_GET_NUM_WAITING) described above there is also
ioctl(SG_GET_PACK_ID) which will return the pack_id (or tag) of the
response that has been waiting the longest to be processed (or -1
if nothing is waiting).

In the area of async polling the existing sg driver supports both
standard Unix techniques and driver-specific techniques that convey
extra information.

>> Here is the full set of extra ioctls I have, or will be proposing:
>>      SG_IOSUBMIT
>>      SG_IOSUBMIT_V3
>>      SG_IORECEIVE
>>      SG_IORECEIVE_V3
>>      SG_IOABORT
>>      SG_SG_SET_GET_EXTENDED
> 
> Well, i/o cancellation is another huge can of worms, but let's get the
> submit interface sorted out first before worrying about how
> cancellation works.

Yes, and its a great way to test code. The sgh_dd utility (sg3_utils
package, testing folder) has a ae=AEN option for "abort every n
commands". When it decides to abort a command it sets up another
(killer) thread that waits a random amount of time (within bounds)
then issues ioctl(SG_IOABORT). Great fun. For even more fun there
is ae=AEN,MAEN where the extra MAEN parameter is for "abort every
n multiple requests invocations". There are a lot more corner cases
when aborting a multiple requests invocation. Testing with these
found several problems with my code.

It seems to me we are not actually on the same page when it comes
to where this project stands.

>> They are all new style ioctls using the _IOR(W) macros with fixed
>> size objects referenced by the ioctl's third argument. ioctls have
>> been referred to as the "garbage bin of Unix". Well that last one is
>> a garbage bin within a garbage bin :-) On the plus side, it keeps
>> that list relatively short.
>>
>> Doug Gilbert
>>
>>
>> *** Tony Battersby is a sg driver power user. He has lamented wading
>> through very large logs looking for some hint of why the sg driver is
>> playing up he has stated the strong preference for more, not less,
>> ioctls.
> 
> I'm not really bothered about the number of ioctls; I'm bothered about
> getting the interface right.

Great. Then please leave ioctl(SG_IO) as is (i.e. sync only).

>> BTW the write()/read() interface still remains in the sg driver after
>> these patchsets. It will continue to only support the sg v3
>> interface. Perhaps calling it should cause a "deprecated" log message
>> once for each kernel run to annoy maintainers of old code.
> 
> That would be ideal given all the security complaints we have about it.

That is easily done.

Doug Gilbert


*** at least with scsi_debug with a command delay set at 5000 nanoseconds.
     With real storage devices with latencies around 50 microseconds or higher
     it may be more reliable. Some sort of handle or the tag itself back from
     blk_execute_rq_nowait() is the real solution.

+++ but the bsg driver can do much more than issue SCSI commands. Question
     is, given the removal of its SCSI async functionality, should it be
     generating SCSI commands at all? Just the general ioctl(SG_IO) as
     supported by sd, sr and st devices should suffice.

^^^ another approach to the write()/read() security problems would be for
     their implementation to check if the given file descriptor was to a
     char (and maybe block) device and if so reduce its exploitable behaviour
     accordingly.
