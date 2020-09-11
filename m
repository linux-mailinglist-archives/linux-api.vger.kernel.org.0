Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299BE2667FA
	for <lists+linux-api@lfdr.de>; Fri, 11 Sep 2020 20:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbgIKSA6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Sep 2020 14:00:58 -0400
Received: from smtp.infotech.no ([82.134.31.41]:47816 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgIKSA5 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 11 Sep 2020 14:00:57 -0400
X-Greylist: delayed 517 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Sep 2020 14:00:57 EDT
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 611E7204191;
        Fri, 11 Sep 2020 19:52:18 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id p-SIdQsLBuAC; Fri, 11 Sep 2020 19:52:10 +0200 (CEST)
Received: from [192.168.48.23] (host-45-78-251-166.dyn.295.ca [45.78.251.166])
        by smtp.infotech.no (Postfix) with ESMTPA id 7E24E20417A;
        Fri, 11 Sep 2020 19:52:08 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH RESEND 2/4] scsi: sg: implement BLKSSZGET
To:     Christoph Hellwig <hch@lst.de>, Tom Yan <tom.ty89@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        akinobu.mita@gmail.com, linux-api@vger.kernel.org
References: <CAGnHSE=bhpL4REG5PXST6dF3gSWeewg1Eqr+sLw_9rtqL-ToFQ@mail.gmail.com>
 <20200906012716.1553-1-tom.ty89@gmail.com>
 <20200906012716.1553-2-tom.ty89@gmail.com> <20200907060927.GA18909@lst.de>
 <CAGnHSEnWPSaM3xS1MtFUJDrSZPfaH_VwAiQ5UkndFTVe3uWNVA@mail.gmail.com>
 <20200908084258.GA17030@lst.de>
 <CAGnHSE=ASs3DG2yp1NpODHimwxHe+=XPRsOyDdkB3ThtyEU-KA@mail.gmail.com>
 <20200910052835.GB18283@lst.de>
 <CAGnHSE=pcW0zJMSaowdsRXFa=TmOeidekgvDuEPB8PU7mheXNA@mail.gmail.com>
 <20200911064844.GA22190@lst.de>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <a8d8e0d3-dfd7-5a2d-8f63-5e1816805c8e@interlog.com>
Date:   Fri, 11 Sep 2020 13:52:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911064844.GA22190@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2020-09-11 2:48 a.m., Christoph Hellwig wrote:
> On Fri, Sep 11, 2020 at 10:52:19AM +0800, Tom Yan wrote:
>>> How is that an advantage?  Applications that works with block devices
>>> don't really work with a magic passthrough character device.
>>
>> You must assume that there are applications already assuming that
>> work. (And it will, at least in some cases, if this series get
>> merged.)
> 
> Why "must" I assume that?
> 
>> And you have not been giving me a solid point anyway, as I said, it's
>> just queue_*() at the end of the day; regardless of whether those
>> would work in all sg cases, we have been using them in the sg driver
>> anyway.
>>
>> And it's not like we have to guarantee that (the) ioctls can work in
>> every case anyway, right? (Especially when they aren't named SG_*).
> 
> No.  While it is unfortunte we have all kinds of cases of ioctls working
> differnetly on different devices.
> 
>>
>> I mean, what's even your point? How do you propose we fix this?
> 
> I propose to not "fix" anything, because nothing is broken except for
> maybe a lack of documentation.

Alan Stern are you reading this thread? Why do I ask, you may ask?
Because 'git blame' fingers you:

vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

commit 44ec95425c1d9dce6e4638c29e4362cfb44814e7
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Tue Feb 20 11:01:57 2007 -0500

     [SCSI] sg: cap reserved_size values at max_sectors

     This patch (as857) modifies the SG_GET_RESERVED_SIZE and
     SG_SET_RESERVED_SIZE ioctls in the sg driver, capping the values at
     the device's request_queue's max_sectors value.  This will permit
     cdrecord to obtain a legal value for the maximum transfer length,
     fixing Bugzilla #7026.

     The patch also caps the initial reserved_size value.  There's no
     reason to have a reserved buffer larger than max_sectors, since it
     would be impossible to use the extra space.

     The corresponding ioctls in the block layer are modified similarly,
     and the initial value for the reserved_size is set as large as
     possible.  This will effectively make it default to max_sectors.
     Note that the actual value is meaningless anyway, since block devices
     don't have a reserved buffer.

     Finally, the BLKSECTGET ioctl is added to sg, so that there will be a
     uniform way for users to determine the actual max_sectors value for
     any raw SCSI transport.

     Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
     Acked-by: Jens Axboe <jens.axboe@oracle.com>
     Acked-by: Douglas Gilbert <dougg@torque.net>
     Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Oops, I ack-ed this patch from 2007:-) Anyway it would seem BLKSECTGET ioctl
was meant to be a "uniform way to determine the actual max_sectors value for
any raw SCSI transport." Given that the initial implementation of BLKSECTGET
now seems to be at odds with other implementations, what should we do?

It is possible that it was correct on 2007 and the BLKSECTGET ioctl has
changed elsewhere but failed to fix the sg driver's implementation.

If I get a vote then it would be for Tom Yan's approach: reduce entropy or
it will overwhelm us :-)


So Christoph, it IS documented, both in the above commit message and:
    https://doug-gilbert.github.io/sg_v40.html

in Table 8. So please stop with your "maybe a lack of documentation" line.

Doug Gilbert

