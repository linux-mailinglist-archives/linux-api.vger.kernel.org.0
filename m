Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84EDB8F238
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 19:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfHORas (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 13:30:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35242 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730598AbfHORas (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 13:30:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id n4so1596381pgv.2;
        Thu, 15 Aug 2019 10:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QnlfD1u/saq7YabHTTJM2fFau3y80kmE4WZcEZvSBiM=;
        b=ueGM7pgLLQOxkbaLXR1h3fvwzCdNAz6YI0mFOBYCD8CK/sfpTYeK4iWKnjjxuANFBl
         8QtO9FRdHQQT0+Rio/tDTmZcxxbGNXX6OjjZPaahH15Pc1zJZ6dExkdWnWid3PoLT14x
         wEqdrwngFrTPx4fdstFaRonutiZuL6H7mUWCgC507vQrhMOuey16RL+lwKlvCS1iRFSr
         haTvAB70nbHzu06cD3+E5i89NoBDRJXDCkToGNmJz8TAZ5VZacUsgLKisSdfW054M27l
         I8DHzGn4rzYvm6X7R3A8zbvn2QTDayDnoxK845y7LsuiaGeoO1icJzvIahkZefRxWYt6
         rEpw==
X-Gm-Message-State: APjAAAVed+YvHIxiHhEK0F2nJ2mw5CoLEkhEJYV6E7ut057yBlkq9YDw
        1/tOY3Y3YumCByA00wUZXPc=
X-Google-Smtp-Source: APXvYqzHLHWkQAegNa1jIJY7/77XgqulqNeMSvORhvP8TO0Ntzgv66iP0wjodakvJ7RdKgVabvaQFg==
X-Received: by 2002:aa7:91d3:: with SMTP id z19mr6500679pfa.135.1565890247488;
        Thu, 15 Aug 2019 10:30:47 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id x9sm2529062pgp.75.2019.08.15.10.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 10:30:46 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
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
Message-ID: <6606add1-7ae7-5d8d-e660-d267164981d9@acm.org>
Date:   Thu, 15 Aug 2019 10:30:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <51e7cdfb-7921-9368-9b78-90ba5ac50c77@interlog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 8/13/19 9:19 PM, Douglas Gilbert wrote:
> Bart Van Assche hinted at a better API design but didn't present
> it. If he did, that would be the first time an alternate API
> design was presented for async usage in the 20 years that I have
> been associated with the driver.

I would like to start from the use cases instead of the implementation 
of a new SG/IO interface. My employer uses the SG/IO interface for 
controlling SMR and HSMR disks. What we need is the ability to discover, 
read, write and configure such disks, support for the non-standard HSMR 
flex protocol, the ability to give certain users or groups access to a 
subset of the LBAs and also the ability to make that information 
persistent. I think that such functionality could be implemented by 
extending LVM and by adding support for all ZBC commands we need in the 
block layer, device mapper layer and also in the asynchronous I/O layer. 
The block, dm and aio layers already support submitting commands 
asynchronously but do not yet support all the ZBC commands that we use.

Are there any SG/IO use cases that have not yet been mentioned in this 
e-mail thread? If SMR and HSMR are the primary use cases for SG/IO, 
should asynchronous command support be added in the SG/IO layer or 
should rather ZBC support in the block, dm and aio layers be improved?

Thanks,

Bart.
