Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD0386D2A
	for <lists+linux-api@lfdr.de>; Fri,  9 Aug 2019 00:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404592AbfHHWZN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 8 Aug 2019 18:25:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38381 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732708AbfHHWZN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Aug 2019 18:25:13 -0400
Received: by mail-pl1-f196.google.com with SMTP id m12so5507288plt.5;
        Thu, 08 Aug 2019 15:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bpHV3e8JAuW9jPJJ+orVfIVb/Mkhh2ezFJLfJa1sqUo=;
        b=oGIB1KHvJJdRdmqHBZuOSslDBsf/CD2aubpAkchu2ooiR0g+f95NW+t+KuaNsVjIDh
         udfGxzWU7cvg/GIZNOVzd48hET2DJLMvPpdztyob//xOfqk0mhHp5D5Rp2k0MAlNa7K+
         vxpODL7TqOdOTjcrs5X4wpfDNlfIuaruTU6Xay9RtlL/GYIbXhKAnDXCDeG8//0pMh6U
         VOnc70JRBTRe7PJYPU+iEguW3VuwK1y5gfgriVbxjmOtgaap46l2eX24jYrLtKmQFmG4
         E/53jQReEUP3aF1/UIcbz3Zx/Tk2Rah4EQPuqoenwzE1lOUbiPqFaLKCKoCxjod7Jzsv
         LI4Q==
X-Gm-Message-State: APjAAAXr6oqsJYUA+GHPsgBfd+wOYc+cf368fZK4YMLRQliIjzzQC4wl
        Z3yy51NlI6CjdfY1mxYBdDxaV49M
X-Google-Smtp-Source: APXvYqyrkrJ7oPFLymWiDXa3nWhvwoWBV3ZZ7HTkjdUbYtz/V+0rjh+rTul8sAay6t9sbFaTLpGAcA==
X-Received: by 2002:a17:902:8d97:: with SMTP id v23mr15608397plo.157.1565303112424;
        Thu, 08 Aug 2019 15:25:12 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 64sm97296085pfe.128.2019.08.08.15.25.11
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 15:25:11 -0700 (PDT)
Subject: Re: [PATCH v3 00/20] sg: add v4 interface
To:     Tony Battersby <tonyb@cybernetics.com>, dgilbert@interlog.com,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     martin.petersen@oracle.com, hare@suse.de,
        Arnd Bergmann <arnd@arndb.de>
References: <20190807114252.2565-1-dgilbert@interlog.com>
 <1565291455.3435.48.camel@linux.vnet.ibm.com>
 <7edab448-22cc-493a-f745-acc5be38f6a5@interlog.com>
 <5a80d09c-c1a5-429d-d46a-5e108b6292df@cybernetics.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <517f279d-38ec-79eb-cc7f-77d1e873ea62@acm.org>
Date:   Thu, 8 Aug 2019 15:25:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5a80d09c-c1a5-429d-d46a-5e108b6292df@cybernetics.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 8/8/19 2:37 PM, Tony Battersby wrote:
> On 8/8/19 5:08 PM, Douglas Gilbert wrote:
>> *** Tony Battersby is a sg driver power user. He has lamented wading through
>>       very large logs looking for some hint of why the sg driver is playing
>>       up. He has stated the strong preference for more, not less, ioctls.
>>
> One of the reasons ioctls have a bad reputation is because they can be
> used to implement poorly-thought-out interfaces.  So kernel maintainers
> push back on adding new ioctls.  But the push back isn't about the
> number of ioctls, it is about the poor interfaces.  My advice was that
> in general, to implement a given API, it would be better to add more
> ioctls with a simple interface for each one rather than to add fewer
> extremely complex multiplexing ioctls.

Hi Tony,

What is your motivation to use the SG_IO API? Is it controlling SMR 
drives or are you using SG_IO for another reason? I'm asking because 
depending on the use case there may be a better solution than using the 
SG_IO API.

Thanks,

Bart.
