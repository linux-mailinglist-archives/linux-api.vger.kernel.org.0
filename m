Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB6B2C7E36
	for <lists+linux-api@lfdr.de>; Mon, 30 Nov 2020 07:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgK3G0Q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Nov 2020 01:26:16 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:46802 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgK3G0Q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Nov 2020 01:26:16 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AU68rfd133207;
        Mon, 30 Nov 2020 06:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=i5CUmWXvplryTp+OUSSNEg/iQ9EnZ/S0gr1miy8aKkM=;
 b=vNc4D+txllGh2ATdWJIxaL1MX/l8LZl367BIsE1YLDRsYx4B4QA1mb1qMsCHGU5sBAkH
 E5M4h1LfjKS5OCARWW+a4ZuRjBiHxD5bckv8PZAChIR5+WmDpWqJ0reGEzgCS1+QTR6k
 Z10CqwzbL1oSqrmrwVgDHhHmn/IPlHmqM1DzKp/bH8opgTbfPDX8/FsNK0vWcBzcHPto
 3faEE9z5vEqnEFdON375qdZIz9g7zzWno7tqklx3AJbzPXLBJhT+3bS4tgoGGQ/GcQqc
 kqGiyvWOue6OqKyoPFxJ3vz+ktvgrUDLXjYsk0VKN+BXBxxm5sGJ6HJjRK7mwGZ2gTov eQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 353c2akjp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Nov 2020 06:24:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AU6BF4J081003;
        Mon, 30 Nov 2020 06:24:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3540fujk0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 06:24:46 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AU6OfQB025572;
        Mon, 30 Nov 2020 06:24:42 GMT
Received: from [192.168.1.7] (/73.15.177.101)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 29 Nov 2020 22:24:41 -0800
Subject: Re: [RFC net-next af_unix v1 0/1] Allow delivery of SIGURG on AF_UNIX
 streams socket
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Paolo Abeni <pabeni@redhat.com>,
        jbi.octave@gmail.com, Linux API <linux-api@vger.kernel.org>
References: <1606618332-23345-1-git-send-email-rao.shoaib@oracle.com>
 <CALCETrUKuzwU=xiDq8Kk8H-bE1R6K-pN5ZhCFWH9bxR+_Z=NwA@mail.gmail.com>
From:   Rao Shoaib <rao.shoaib@oracle.com>
Message-ID: <2f9f5186-cac3-b6b9-eaf3-4fdfdf8609e0@oracle.com>
Date:   Sun, 29 Nov 2020 22:24:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUKuzwU=xiDq8Kk8H-bE1R6K-pN5ZhCFWH9bxR+_Z=NwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9820 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300041
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9820 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011300041
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Andy,

Thanks for your comments. The RFC proposes implementing missing features 
of the current socket API for AF_UNIX sockets. It does not change any 
aspect of the current API[1]. Your comments are about issues with the 
current socket API and hence are not in the scope of this RFC. We can 
work on a different RFC to address issues with the current socket API.

[1] The only feature missing in the RFC is delivery of urgent data 
marker, RFC proposes to implement only the generation of SIGURG. 
Delivery of the urgent marker was dropped based on internal feedback. I 
am open to adding that to make the API comparable to TCP. Unlike TCP, 
there is no ambiguity regarding the position of urgent byte for AF_UNIX 
sockets, as the communication is between two sockets on the same system. 
Currently the behavior is controlled via a configuration option, and 
that option will apply to both sockets.

Regards,

Shoaib

On 11/28/20 8:02 PM, Andy Lutomirski wrote:
> On Sat, Nov 28, 2020 at 7:07 PM <rao.shoaib@oracle.com> wrote:
>> From: Rao Shoaib <rao.shoaib@oracle.com>
>>
>> We have a use case where thousands of processes connect locally to a
>> database and issue queries that are serviced by a pool of threads.
>> Communication is done over AF_UNIX sockets. Currently, there is no way
>> for the submitter to signal the servicing thread about an urgent
>> condition such as abandoning the query.
> Sure there is.  You could close() the socket.  You could send() a
> message saying that your query wants to be canceled.  You could use a
> second socket for this if it's somehow inconvenient to do it with a
> single socket.
>
>> This patch addresses that
>> requirement by adding support for MSG_OOB flag for AF_UNIX sockets.
>> On receipt of such a flag, the kernel sends a SIGURG to the peer.
> SIGURG is a horrible interface.  It doesn't scale -- signals are slow,
> and they give no indication of *which* socket has urgent data.  Aside
> from this, the "urgent" interface itself is nuts -- even the TCP RFCs
> and implementations seem unable to agree on exactly how to tell
> *which* data is urgent.  At least epoll might be a scalable way to
> tell which socket has urgent data, but that's not what your patch
> description seems to be talking about.
>
> Oh yeah, SIGURG simply doesn't work across privilege boundaries.
>
> I'm also a bit nervous that there might be some program out there that
> expects SIGIO but not SIGURG on unix sockets, and you're breaking
> them.
>
> --Andy
