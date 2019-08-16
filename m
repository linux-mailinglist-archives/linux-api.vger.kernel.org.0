Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51EAC90782
	for <lists+linux-api@lfdr.de>; Fri, 16 Aug 2019 20:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfHPSKj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Aug 2019 14:10:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42738 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfHPSKj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Aug 2019 14:10:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id p3so3311154pgb.9;
        Fri, 16 Aug 2019 11:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g3Rtqd5AFTZf6nYXP6J7lz92csL9uIjbEcEcwtwYRRw=;
        b=Jq4VaaH4kjvkY+bBzy6ZR/qjaNtLa60CNfuddJ7dFI32pOT9VqSciVfTKLiPoprFlE
         c77tQX3tW/hyN53z7TYnONFVShHUViMEuAp+KcDGFgfer5j2GFOjauuSKiaz3um9w/BL
         8welwAb4+hucBIja7WyOmUWVz9lG6j2XqDbfH9/RNbHd+VzFWW4CyKuATTQuONJHJRqT
         2dgOegzS97pA8dlJD8ZqmFtSXTfsJVtcmziGS6KdQI0eJVRh6s0xFIcyUMnAGf7zZL5H
         KqRLBkzW64Eb/akbut6L1Gl3VUWGdbSxy11HRyyZ7Qc/ab0sekcl7VYjeZCdeW7cM/oB
         tGTg==
X-Gm-Message-State: APjAAAX/PGD7aDJ8hNOWhxTn8+VAN/QCH4smYgw1HDvrg+zXSlNVthe1
        +WZBb/2By0wLUWxQNoVRB1U=
X-Google-Smtp-Source: APXvYqwefgCTm02Zk4vb33Cg30dAXglQjkJZ1DqupmIjiFqWo/tqNkyv6kdrlQM/1wCeaX8SRLSVrA==
X-Received: by 2002:a17:90a:ca0f:: with SMTP id x15mr8251943pjt.82.1565979038433;
        Fri, 16 Aug 2019 11:10:38 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id u3sm4159655pjn.5.2019.08.16.11.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 11:10:37 -0700 (PDT)
Subject: Re: [PATCH v3 00/20] sg: add v4 interface
To:     dgilbert@interlog.com, James Bottomley <jejb@linux.vnet.ibm.com>,
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
 <d0c60641-0607-a9c4-e79d-b6e850ef8682@interlog.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e25e6a74-4d54-3d91-d48d-ba9c91b2a874@acm.org>
Date:   Fri, 16 Aug 2019 11:10:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d0c60641-0607-a9c4-e79d-b6e850ef8682@interlog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 8/16/19 8:59 AM, Douglas Gilbert wrote:
> On 2019-08-15 1:30 p.m., Bart Van Assche wrote:
>> HSMR disks. What we need is the ability to discover, read, write and 
>> configure such disks, support for the non-standard HSMR flex protocol, 
>> the ability to give certain users or groups access to a subset of the 
>> LBAs and also the ability to make that information persistent. I think 
>> that such functionality could be implemented by extending LVM and by 
>> adding support for all ZBC commands we need in the block layer, device 
>> mapper layer and also in the asynchronous I/O layer. The block, dm and 
>> aio layers already support submitting commands asynchronously but do 
>> not yet support all the ZBC commands that we use.
> 
> I believe that you will find that the more layers of abstraction that are
> placed between the actual device and the OS level API, the more difficult
> the discovery process will be. And in some cases you will need to get to
> a management layer to let those management functions "pass-through" those
> layers. Some RAID card drivers take advantage of the no_uld_attach flag in
> scsi_device to expose real devices, but only to the sg/bsg interface for
> management purposes (for utilities like smartmontools) and do not produce
> sd device nodes.

Isn't the very purpose of an operating system to provide device drivers 
and other abstraction layers such that not every application has to 
implement these?

My opinion is that using SG/IO to control SMR disks is suboptimal. A 
very powerful feature of the Linux block layer is the ability to stack 
block drivers. SG/IO is fundamentally incompatible with stacking block 
drivers. Stacking requires having access to the LBA, request size and 
other block layer request attributes. I don't think that we want to add 
code for parsing SCSI, NVMe pass-through commands etc. in block drivers 
as the device mapper.

Hence my proposal to improve support in the block layer for ZBC instead 
of using SG/IO to control SMR disks.

Bart.

