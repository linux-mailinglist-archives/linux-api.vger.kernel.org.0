Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80E402A092
	for <lists+linux-api@lfdr.de>; Fri, 24 May 2019 23:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404252AbfEXVn1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 May 2019 17:43:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60204 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404339AbfEXVnZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 May 2019 17:43:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4OLdSlE141964;
        Fri, 24 May 2019 21:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=5ZYOEzS+65K8bB/ZHCHtVMV0q6W5qUrvuM4ooNhr7KA=;
 b=m+Zhhh6bDXlaH1hAoV9gd9ihKiKeb6nlkBYBgRMj+BZ38id0RqowMWRjt6wKtIptu7jM
 V5LvrzcunUIC2M9aHa7Lhz8vwdFsYhJIr+IEpJHXTQJrBNVw2PDwFWns+SUkHrXUhp1z
 ws62Zjw3BrtWx0HiRj+WN/Me+RoLyUUyWZTMKXNVcGUKDmoShFrg1wkG9Yu120lCzOQ6
 zTD5DrSu0fgXVIydHgRcbqeEGca7YgMFmKAsHdS7rqgodWOlU5hztSQOYxxx9gFc2mai
 iEAb3F37E4XWVYZPO3j41WDxYJ3rzu8pBjLswBwpyde6jwpFDyRLsnqmdP/igSiq6gUy 8g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2smsk5kgm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 21:43:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4OLhBln162017;
        Fri, 24 May 2019 21:43:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2smshg3ec9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 21:43:10 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4OLh4p9016253;
        Fri, 24 May 2019 21:43:04 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 May 2019 21:43:04 +0000
Date:   Fri, 24 May 2019 17:43:04 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jordan, Tobias" <Tobias.Jordan@elektrobit.com>,
        akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, linux-api@vger.kernel.org
Subject: Re: [PATCH] mm: mlockall error for flag MCL_ONFAULT
Message-ID: <20190524214304.enntpu4tvzpyxzfe@ca-dmjordan1.us.oracle.com>
References: <20190522112329.GA25483@er01809n.ebgroup.elektrobit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190522112329.GA25483@er01809n.ebgroup.elektrobit.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9267 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905240141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9267 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905240141
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[ Adding linux-api and some of the people who were involved in the
MCL_ONFAULT/mlock2/etc discussions.  Author of the Fixes patch appears to
have moved on. ]

On Wed, May 22, 2019 at 11:23:37AM +0000, Potyra, Stefan wrote:
> If mlockall() is called with only MCL_ONFAULT as flag,
> it removes any previously applied lockings and does
> nothing else.

The change looks reasonable.  Hard to imagine any application relies on it, and
they really shouldn't be if they are.  Debian codesearch turned up only a few
cases where stress-ng was doing this for unknown reasons[1] and this change
isn't gonna break those.  In this case I think changing the syscall's behavior
is justified.  

> This behavior is counter-intuitive and doesn't match the
> Linux man page.

I'd quote it for the changelog:

  For mlockall():

  EINVAL Unknown  flags were specified or MCL_ONFAULT was specified with‐
         out either MCL_FUTURE or MCL_CURRENT.

With that you can add

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>

[1] https://sources.debian.org/src/stress-ng/0.09.50-1/stress-mlock.c/?hl=203#L203
