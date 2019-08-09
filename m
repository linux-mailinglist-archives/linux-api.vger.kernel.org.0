Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30DD687B8E
	for <lists+linux-api@lfdr.de>; Fri,  9 Aug 2019 15:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406503AbfHINmv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 9 Aug 2019 09:42:51 -0400
Received: from mail.cybernetics.com ([173.71.130.66]:55372 "EHLO
        mail.cybernetics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfHINmv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Aug 2019 09:42:51 -0400
X-Greylist: delayed 833 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Aug 2019 09:42:50 EDT
X-ASG-Debug-ID: 1565357334-0fb3b0188454c7b0001-wjuz9g
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id nxLn55IMaWHgjfyE (version=SSLv3 cipher=DES-CBC3-SHA bits=112 verify=NO); Fri, 09 Aug 2019 09:28:54 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
Received: from [10.157.2.224] (account tonyb HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 5.1.14)
  with ESMTPSA id 9045384; Fri, 09 Aug 2019 09:28:54 -0400
Subject: Re: [PATCH v3 00/20] sg: add v4 interface
To:     Bart Van Assche <bvanassche@acm.org>, dgilbert@interlog.com,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
X-ASG-Orig-Subj: Re: [PATCH v3 00/20] sg: add v4 interface
Cc:     martin.petersen@oracle.com, hare@suse.de,
        Arnd Bergmann <arnd@arndb.de>
References: <20190807114252.2565-1-dgilbert@interlog.com>
 <1565291455.3435.48.camel@linux.vnet.ibm.com>
 <7edab448-22cc-493a-f745-acc5be38f6a5@interlog.com>
 <5a80d09c-c1a5-429d-d46a-5e108b6292df@cybernetics.com>
 <517f279d-38ec-79eb-cc7f-77d1e873ea62@acm.org>
From:   Tony Battersby <tonyb@cybernetics.com>
Message-ID: <cd26b3a8-5943-6e3b-9e81-4cfd280777c1@cybernetics.com>
Date:   Fri, 9 Aug 2019 09:28:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <517f279d-38ec-79eb-cc7f-77d1e873ea62@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1565357334
X-Barracuda-Encrypted: DES-CBC3-SHA
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1747
X-Barracuda-BRTS-Status: 1
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 8/8/19 6:25 PM, Bart Van Assche wrote:
> On 8/8/19 2:37 PM, Tony Battersby wrote:
>> On 8/8/19 5:08 PM, Douglas Gilbert wrote:
>>> *** Tony Battersby is a sg driver power user. He has lamented wading through
>>>       very large logs looking for some hint of why the sg driver is playing
>>>       up. He has stated the strong preference for more, not less, ioctls.
>>>
>> One of the reasons ioctls have a bad reputation is because they can be
>> used to implement poorly-thought-out interfaces.  So kernel maintainers
>> push back on adding new ioctls.  But the push back isn't about the
>> number of ioctls, it is about the poor interfaces.  My advice was that
>> in general, to implement a given API, it would be better to add more
>> ioctls with a simple interface for each one rather than to add fewer
>> extremely complex multiplexing ioctls.
> Hi Tony,
>
> What is your motivation to use the SG_IO API? Is it controlling SMR 
> drives or are you using SG_IO for another reason? I'm asking because 
> depending on the use case there may be a better solution than using the 
> SG_IO API.
>
> Thanks,
>
> Bart.
>
Actually I used the asynchronous write()/read()/poll() sg interface to
implement RAID-like functionality for tape drives and medium changers,
in a commercial product that has been around since 2002.  These days our
products use a lot more disk I/O than tape I/O, so I don't write much
new code using the sg interface anymore, although that code is still
there and has to be maintained as needed.  So I don't have any immediate
plans to use any of the new sgv4 features being introduced, and
unfortunately I am way too busy to even give it a good review...

Tony Battersby
Cybernetics

