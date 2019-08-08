Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81BD886D88
	for <lists+linux-api@lfdr.de>; Fri,  9 Aug 2019 01:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403979AbfHHXBA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 8 Aug 2019 19:01:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725785AbfHHXA7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Aug 2019 19:00:59 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x78MvbV4094757;
        Thu, 8 Aug 2019 19:00:47 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u8tdk5t4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Aug 2019 19:00:47 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x78MtJRX021371;
        Thu, 8 Aug 2019 23:00:46 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04wdc.us.ibm.com with ESMTP id 2u51w6d4e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Aug 2019 23:00:46 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x78N0jgi26804602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Aug 2019 23:00:45 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 801D6124054;
        Thu,  8 Aug 2019 23:00:45 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 713CF124053;
        Thu,  8 Aug 2019 23:00:44 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.197.215])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Aug 2019 23:00:44 +0000 (GMT)
Message-ID: <1565305243.25619.27.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 00/20] sg: add v4 interface
From:   James Bottomley <jejb@linux.vnet.ibm.com>
To:     dgilbert@interlog.com, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-api@vger.kernel.org
Cc:     martin.petersen@oracle.com, hare@suse.de, bvanassche@acm.org,
        Arnd Bergmann <arnd@arndb.de>,
        Tony Battersby <tonyb@cybernetics.com>
Date:   Thu, 08 Aug 2019 16:00:43 -0700
In-Reply-To: <7edab448-22cc-493a-f745-acc5be38f6a5@interlog.com>
References: <20190807114252.2565-1-dgilbert@interlog.com>
         <1565291455.3435.48.camel@linux.vnet.ibm.com>
         <7edab448-22cc-493a-f745-acc5be38f6a5@interlog.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=636 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080205
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 2019-08-08 at 23:08 +0200, Douglas Gilbert wrote:
> On 2019-08-08 9:10 p.m., James Bottomley wrote:
> > On Wed, 2019-08-07 at 13:42 +0200, Douglas Gilbert wrote:
> > > This patchset extends the SCSI generic (sg) driver found in
> > > lk 5.3 .  The sg driver has a version number which is visible
> > > via ioctl(SG_GET_VERSION_NUM) and is bumped from 3.5.36 to
> > > 4.0.03 by this patchset. The additions and changes are
> > > described in some detail in this long webpage:
> > >      http://sg.danny.cz/sg/sg_v40.html
> > > 
> > > Most new features described in the above webpage are not
> > > implemented in this patchset.
> > 
> > Since this will be an extension of something that exists both in
> > your sg driver and in the block bsg interface (and thus needs an
> > implementation there), I added both linux-block and linux-api to
> > the cc (the latter because you're adding to an API).
> 
> The SG_IO ioctl has been the synchronous SCSI pass-through interface
> for over 15 years. Its quirk is that it takes two different formats
> depending on the character device its file descriptor belongs to:
>     - sg device file descriptor: sg v3 interface (struct sg_io_hdr)
>     - bsg device file descriptor: sg v4 interface (struct sg_io_v4)
> 
> I'm only proposing one change in the synchronous interface based
> on the SG_IO ioctl: to additionally accept the sg v4 interface in
> the sg driver.

Right, as I said below, adding v4 to sg looks to be fine.  We don't
need v3 in BSG since v4 is a superset.

> Arnd Bergmann considers two interface structures through one ioctl
> as undesirable but is prepared to accept SG_IO. His POV is as the
> maintainer of 32/64 bit compatibility ioctls. The case of SG_IO
> is a well established exception to his rules (i.e. a known evil).
> 
> I don't believe extending ioctl SG_IO for asynchronous work is a
> good idea. As pointed out above, it is already overloaded too
> much. Additionally it would need further flags to differentiate
> these cases:
>     - sync/async
>     - if async: submission or reception
>     - and optionally if async: abort (an inflight request)
>     - and do you want to add multiple requests in there too?
> 
> So are you looking at reducing the number of ioctl to the absolute
> minimum? If so I don't think the SG_IO ioctl is the correct vehicle
> for that. It doesn't use the _IOR(W) macros, instead it is hard
> coded at 0x2285 ***. And the size checking offered by the _IOR(W)
> macro (on the object pointed to by the 3rd argument) is useless with
> SG_IO because it takes two different sized objects. Worse, one of
> those objects changes size between 32 and 64 bits, while the other
> does not.

OK, so this is where interface design is important.  It's perfectly
possible to design an async interface using the current v4 BSG SG_IO. 
You simply open the device O_NONBLOCK and send the ioctl which will
return immediately.  To find out when it returns you poll (we'd
obviously need to add polling in bsg, but that's fairly simple).  Since
 poll/select/epoll is our standard async event handling mechanism, we
should at least try it and have a good reason why it doesn't work
before inventing our own equivalent.

> Stepping back, this started about 18 months ago when security
> janitors got upset about the bsg driver's use of write()/read() for
> its async interface. Linus Torvalds suggested SG_IOSUBMIT and
> SG_IORECEIVE to replace write() and read() respectively in bsg.
> Instead the write()/read() interface was removed from the bsg driver.
> With it went the ability to submit multiple requests in one write()
> call (by passing an array of sg_io_v4 objects rather than just one).
> My intention is to re-add that capability in the sg driver, using the
> ioctls that Linus suggested.

What I'm saying is let's discuss the interface design before we add it.
 the submit/receive interface is essentially a packet one.  The problem
with a packet one is that we're request/response where the response
likely altered some user memory area, so each response has to be
matched with the outbound request to find out what happened ... how is
that done?

One way to do it simply with existing SG_IO is to allow only one
outstanding request per FD, so if you want five requests, you open five
FDs and then poll all of them to see which one returns.  I'm not saying
it's the best because FDs are a somewhat precious commodity, but it is
possible and it's a simple extension of what exists today.

> Initially I had both the sg v3 and v4 interfaces passing through the
> two ioctls. Arnd Bergmann preferred that a separate pair of ioctls
> be used for each interface. Hence SG_IOSUBMIT_V3 and SG_IORECEIVE_V3
> were added for the v3 interface. And thus SG_IOSUBMIT and
> SG_IORECEIVE only use the v4 interface. This cleaned up my code and
> documentation. As a bonus, all four ioctls use the _IORW macros and
> can check the fixed size of the third argument to each ioctl
> invocation.

Can we talk first about how the interface should work.  We can get into
assigning ioctls and what extensions are needed later.

> > Simply extending sg to use the v4 header protocol in
> > uapi/linux/bsg.h is fine modulo the code being in the right
> > form.  The problems are the new ioctls you want to add that would
> > need to be present there as well.
> 
> Why? The bsg driver has never accepted the sg v3 interface. It has
> also removed functionality that I'm trying to re-add in this, and a
> follow-on patchset. The bsg driver has reduced its functionality as a
> generalized SCSI pass-through, but it has more than enough other
> roles to justify its existence, for example as a SMP (SAS) pass-
> through and a driver/transport specific pass-through to various LLDs.
> I don't see the need for the sg and bsg driver to move forward in
> lockstep.

You quote Linus a lot above, but he also said "I wonder if we could at
least try to unify the bsg/sg code - possibly by making sg use the
prettier bsg code (but definitely have to add all the security
measures)".  It's in the interests of unity that we need to make the
code paths look the same as possible, so eventually one could call the
other.  ideally sg would call bsg for v4 and we'd add async to bsg so
it would work for both.

> >   The specific question being how we support async or non-blocking
> > I/O on the sg and bsg interfaces.  The standard way we add
> > asynchronous I/O is supposed to be via .poll on the file
> > descriptor.  you already use read and write in sg and bsg doesn't
> > have a polling interface,
> 
> It is hard to parse that last sentence; the sg driver has always
> supported select/poll/epoll (and SIGIO plus RT signals). sg_poll()
> will work just as well irrespective of whether a request is submitted
> by write(), ioctl(SG_IOSUBMIT) or ioctl(SG_IOSUBMIT_V3).

The way I read how the interface works, it only works when the fd is
ready for read (i.e. a packet submitted with read has returned).  We
need to extend it to make it work with ioctl.  Since ioctl returns
isn't either a 'ready to read' or 'ready to write' event on the fd I
was suggesting using 'msg ready' event for it.

> > but it looks like we could use MSG to signal an ioctl is ready to
> > be serviced for both.  Would shifting to a non-blocking poll based
> > interface for ioctls remove the need to add these
> > SG_IOSUBMIT/SG_IORECEIVE ioctls since we could now do everything
> > over blocking or non-blocking SG_IO?
> 
> Not sure what the MSG is you refer to. The sg driver has had
> ioctl(SG_GET_NUM_WAITING) for a long time. And it is made even
> more lightweight in this patchset: it takes no locks, just reads one
> atomic (a counter obviously) and returns. My guess is its faster the
> select()/poll()/epoll() but doesn't have the ability to monitor
> multiple file descriptors.

the poll interfaces don't tell you how many outstanding request you
have, they tell you when some event happened on the fd.  The event
we're looking for with async packets is an indication of what
completed.

> Here is the full set of extra ioctls I have, or will be proposing:
>     SG_IOSUBMIT
>     SG_IOSUBMIT_V3
>     SG_IORECEIVE
>     SG_IORECEIVE_V3
>     SG_IOABORT
>     SG_SG_SET_GET_EXTENDED

Well, i/o cancellation is another huge can of worms, but let's get the
submit interface sorted out first before worrying about how
cancellation works.

> They are all new style ioctls using the _IOR(W) macros with fixed
> size objects referenced by the ioctl's third argument. ioctls have
> been referred to as the "garbage bin of Unix". Well that last one is
> a garbage bin within a garbage bin :-) On the plus side, it keeps
> that list relatively short.
> 
> Doug Gilbert
> 
> 
> *** Tony Battersby is a sg driver power user. He has lamented wading
> through very large logs looking for some hint of why the sg driver is
> playing up he has stated the strong preference for more, not less,
> ioctls.

I'm not really bothered about the number of ioctls; I'm bothered about
getting the interface right.

> BTW the write()/read() interface still remains in the sg driver after
> these patchsets. It will continue to only support the sg v3
> interface. Perhaps calling it should cause a "deprecated" log message
> once for each kernel run to annoy maintainers of old code.

That would be ideal given all the security complaints we have about it.

James

