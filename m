Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB2CD199A3C
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2020 17:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbgCaPt2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 31 Mar 2020 11:49:28 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13298 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730548AbgCaPt2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 31 Mar 2020 11:49:28 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e8366250000>; Tue, 31 Mar 2020 08:47:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 31 Mar 2020 08:49:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 31 Mar 2020 08:49:26 -0700
Received: from [10.2.57.122] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 31 Mar
 2020 15:49:25 +0000
Subject: Re: [PATCH 3/3] kernel/hung_task convert hung_task_panic boot
 parameter to sysctl
To:     Vlastimil Babka <vbabka@suse.cz>, Kees Cook <keescook@chromium.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-mm@kvack.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <20200330115535.3215-1-vbabka@suse.cz>
 <20200330115535.3215-4-vbabka@suse.cz> <202003301042.97F3B00@keescook>
 <13ae67d8-4b31-db20-7ba4-1602906a291e@nvidia.com>
 <37b42835-6c4a-674b-9731-ecc9d0ff1703@suse.cz>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <ed235358-8a25-61ca-1295-911a21810a47@nvidia.com>
Date:   Tue, 31 Mar 2020 08:49:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <37b42835-6c4a-674b-9731-ecc9d0ff1703@suse.cz>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585669669; bh=cqXhut2aGqGvWiYl/OLkzlunQkw2ez3E0c3b4HvZBpg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=nxUYO+tXSTN1iaxCgy/pHzoBKnUhJElZGaP1iZbqm02LPMOaKtkuA0nY/Cnc0BRvt
         FCQpb7FmR8p5KvUEUzNUz0IQgrSXm8ymdg2GgS2XtmNeFUIGZAhH8kxzuc0lh2vUhj
         z7SuI0idXXe+3Et5tAzVvtK5FcH+P8cZmCdRrk63ChxCdQLLDfeuW/vYyrxeKBCQQN
         FbTQuho+tWgBDm7zXAtlHrk0bq06nJZC+B4o15reMLu1IHQWI6+DB7lhjx3Fe7CTXY
         8gdNxk9zFSdaWNNrxj13+0w2vHLGKYFKUsp09EVO67HXFxkPRy0RxndwWriyeW9Xv+
         wWeTxV78RkADQ==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/31/20 12:27 AM, Vlastimil Babka wrote:
...
> Patches 2+3 are only about handling the legacy boot params that have a sysctl
> counterpart.
> 

OK, I misread what those were for.


>> In fact, the sysctl_aliases[] is (or could be) effectively the whitelist that Luis Chamberlain
>> was requesting in another thread. A whitelist makes good sense, for the reasons Luis listed.
>> As such, keeping it limited to items that we want, seems like the way to go, IMHO.
> 
> See my reply there once I send it :)
> 

Saw that, and it all sounds good now.


thanks,
-- 
John Hubbard
NVIDIA
