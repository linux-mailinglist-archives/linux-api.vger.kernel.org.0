Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90470869CD
	for <lists+linux-api@lfdr.de>; Thu,  8 Aug 2019 21:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404626AbfHHTLF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 8 Aug 2019 15:11:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405415AbfHHTLE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Aug 2019 15:11:04 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x78J7BE4088024
        for <linux-api@vger.kernel.org>; Thu, 8 Aug 2019 15:11:03 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u8q6jp3up-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-api@vger.kernel.org>; Thu, 08 Aug 2019 15:11:02 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-api@vger.kernel.org> from <jejb@linux.vnet.ibm.com>;
        Thu, 8 Aug 2019 20:11:01 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Aug 2019 20:10:58 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x78JAvpN53936594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Aug 2019 19:10:57 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10BCB112062;
        Thu,  8 Aug 2019 19:10:57 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 218FB112061;
        Thu,  8 Aug 2019 19:10:56 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.197.215])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Aug 2019 19:10:55 +0000 (GMT)
Subject: Re: [PATCH v3 00/20] sg: add v4 interface
From:   James Bottomley <jejb@linux.vnet.ibm.com>
To:     Douglas Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     martin.petersen@oracle.com, hare@suse.de, bvanassche@acm.org
Date:   Thu, 08 Aug 2019 12:10:55 -0700
In-Reply-To: <20190807114252.2565-1-dgilbert@interlog.com>
References: <20190807114252.2565-1-dgilbert@interlog.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19080819-0052-0000-0000-000003E95F5F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011571; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01243968; UDB=6.00656263; IPR=6.01025446;
 MB=3.00028096; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-08 19:11:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080819-0053-0000-0000-000062060CE5
Message-Id: <1565291455.3435.48.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=528 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080172
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, 2019-08-07 at 13:42 +0200, Douglas Gilbert wrote:
> This patchset extends the SCSI generic (sg) driver found in
> lk 5.3 .  The sg driver has a version number which is visible
> via ioctl(SG_GET_VERSION_NUM) and is bumped from 3.5.36 to
> 4.0.03 by this patchset. The additions and changes are
> described in some detail in this long webpage:
>     http://sg.danny.cz/sg/sg_v40.html
> 
> Most new features described in the above webpage are not
> implemented in this patchset.

Since this will be an extension of something that exists both in your
sg driver and in the block bsg interface (and thus needs an
implementation there), I added both linux-block and linux-api to the cc
(the latter because you're adding to an API).

Simply extending sg to use the v4 header protocol in uapi/linux/bsg.h
is fine modulo the code being in the right form.  The problems are the
new ioctls you want to add that would need to be present there as well.
 The specific question being how we support async or non-blocking I/O
on the sg and bsg interfaces.  The standard way we add asynchronous I/O
is supposed to be via .poll on the file descriptor.  you already use
read and write in sg and bsg doesn't have a polling interface, but it
looks like we could use MSG to signal an ioctl is ready to be serviced
for both.  Would shifting to a non-blocking poll based interface for
ioctls remove the need to add these SG_IOSUBMIT/SG_IORECEIVE ioctls
since we could now do everything over blocking or non-blocking SG_IO?

James



