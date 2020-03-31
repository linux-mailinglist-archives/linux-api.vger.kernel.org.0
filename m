Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 430EC19A1A0
	for <lists+linux-api@lfdr.de>; Wed,  1 Apr 2020 00:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbgCaWHE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 31 Mar 2020 18:07:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56892 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730556AbgCaWHE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 31 Mar 2020 18:07:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02VM3PUP094446;
        Tue, 31 Mar 2020 22:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=rUoxRaq8zJ1M33HtxzdG0arbaovkRnSxRH57dtpFmRA=;
 b=FAlRPySVwg+BCZQpz4djiUX1gWCZe6coFpSDaMwJ6GAbvCQwT/uKVPqMttjUpqROX6v4
 rBAUkQN4J5jB8kP/1kvtzAlbTCQ/aR0ADvISN6QGSK6ZFS26kt6ZEvH4A5ODZtEzjlBj
 fJrWlrtTFnseSiyagVJi66b8WKGSmpJiJUJrdSWjBqe6gPA/WMzvh4UlOaeDHRvmz8O4
 n2HTRXh+3z/7iZME42QjV7/oFgkfQ032N9m7g7b1kqrcmfRUy5+wMWwC7vRs+/XiM+o3
 FEZ8WR1GaPnfk/aHyLFJWpxphPR6pGEavn+bW9C2lBosJpgurha7fxoUVmvprPg77EK7 tA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 303yun4t3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 22:06:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02VM2xXd100163;
        Tue, 31 Mar 2020 22:04:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 302gcdudwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 22:04:56 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02VM4tYm001789;
        Tue, 31 Mar 2020 22:04:55 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 31 Mar 2020 15:04:55 -0700
Subject: Re: [PATCH] mm: allow checking length for hugetlb mapping in mmap()
To:     Li Xinhai <lixinhai.lxh@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc:     Linux API <linux-api@vger.kernel.org>,
        akpm <akpm@linux-foundation.org>
References: <1585451295-22302-1-git-send-email-lixinhai.lxh@gmail.com> <>
 <f8b5b647-9041-8127-925c-1c8dcb508f24@nvidia.com>
 <2020032916093522557671@gmail.com>
 <5e02a305-038f-b86c-31e7-85358563cbc5@oracle.com>
 <2020033116350399980494@gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e8e8ea0b-f912-2084-ee28-d4da1968e70a@oracle.com>
Date:   Tue, 31 Mar 2020 15:04:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2020033116350399980494@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9577 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003310180
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9577 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003310180
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/31/20 1:35 AM, Li Xinhai wrote:
> My understanding may wrong, but it seems that once some application start to use
> some behavior of kernel, although that usage in user space is not logical, they
> will be protected from change in kernel side.

Correct.  I too wish that the length argument to mmap for hugetlb mappings
was required to be a multiple of huge page size.  That would make everything
nice and consistent.  However, the behavior of rounding the length up to huge
page size has existed for quite some time and it well documented.  Therefore,
we can not change it without the possibility of breaking some application.

-- 
Mike Kravetz
