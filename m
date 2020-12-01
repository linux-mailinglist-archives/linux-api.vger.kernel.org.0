Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595282CAA64
	for <lists+linux-api@lfdr.de>; Tue,  1 Dec 2020 19:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404221AbgLASB6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 1 Dec 2020 13:01:58 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16480 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgLASB5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 1 Dec 2020 13:01:57 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc684eb0001>; Tue, 01 Dec 2020 10:01:15 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 1 Dec
 2020 18:01:15 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 1 Dec 2020 18:01:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIvv93DOJqTSfVNnS0si2Ol4vNWDftbOG6Y4EYYaTIkEN4zZpfZBPGMoeqRIB6832RsbBHV6H/Jw02SZabqfGyC8ZRKuKcEO+5/f0WvmMoLtajL2EwWEGWUdeLU8mFK5Q6MeN1kTQFLqZZHvNgvyldLYAa6BJUMIyIodDzuSjVj/yMUkp5J7RXSDtbb9ygvactmee0/MVBV5sDoRhcpCu5KmZUCjGvusBWRZQC/+qseeCbPJohhH+WnI09ZnM97Ph4r4HoRvHYleC3vG8pPsP2Z5aWaGWQ/Q+xZZTDYZGm3XybzTyHL6rUOEtcEWUxQAdhgCOKCC+rRCIdakmxmr1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hafZzjATtu2mX19gY6LAnVioZz1FqT2kyJuaRi9Zo6k=;
 b=LJVydS4qt0r1MY+07ThBZPXju/ZZAN+ccdeUCJmI/hYpbNB9tVtOq+WphKCyyZjNIvLAjejDerzFxQUTxwQZ0JOM9LWBhBHE/vufIdJhY+DGzSCrfH3K71aZ54dZAzhBs6Olq1VlhBDCTlLC+iK7k+g8uDJBGx+LHL/Zk/l1Pp8HueNT+vQAafgxt5o5CO2NFtvaU//qpk1IN5cOaHHsKKEGLuOusvccs2p74FVsbVSND9ZyEHhJscFyb41GHa+pujHuF7FH66xVbcJTVPSZYV1uMY/7JIjW4V+38IMKoDoMjzjcvpHXTKaDHTyFZCAa8Npw4ZvftZ+d/cqUDQmTMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 1 Dec
 2020 18:01:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3611.031; Tue, 1 Dec 2020
 18:01:13 +0000
Date:   Tue, 1 Dec 2020 14:01:11 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>,
        <linux-mm@kvack.org>, <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>,
        Mircea Cirjaliu <mcirjaliu@bitdefender.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [RESEND RFC PATCH 0/5] Remote mapping
Message-ID: <20201201180111.GA1074504@nvidia.com>
References: <20200904113116.20648-1-alazar@bitdefender.com>
 <20200904121148.GR24045@ziepe.ca>
 <20200904194139.GA5881@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200904194139.GA5881@casper.infradead.org>
X-ClientProxiedBy: MN2PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:208:c0::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR05CA0005.namprd05.prod.outlook.com (2603:10b6:208:c0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.6 via Frontend Transport; Tue, 1 Dec 2020 18:01:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kk9xf-004ViB-17; Tue, 01 Dec 2020 14:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606845675; bh=kVBl4qffB0PMZzayVp89igSBN2O+SlLrNbvle5/c/EI=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=ONiAAFm5L5uHy5uEIqqdWAWdgRANlXEriWbznx74zFEn3jcYZyEoiboG8zTec7O9A
         5A6mZE+8PLwLSZ9sgnSjTvScJoTjdn9HnCVJgvcY/J01QZr7kByC78DsKAGcAGy0wg
         L1aFGMec77PhVvO9rUrMuOmQgciXD0junYEx70e04AX8h4F3jeXd5vXTtfWHbKrSB8
         6nyCC6fV3eMP/pJnCg5055LuH2cvHZ+IVQOC+dXa9FOoh8iLvf+2GinLVHWzzA3MFr
         ZLi4tz+igKsxYU7Wy3oP0ctSp35zJsj2oLBazxAraYNUJPhbKS5jSMBbXjkzmi6hCy
         aEdKU17bRDukA==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 04, 2020 at 08:41:39PM +0100, Matthew Wilcox wrote:
> On Fri, Sep 04, 2020 at 09:11:48AM -0300, Jason Gunthorpe wrote:
> > On Fri, Sep 04, 2020 at 02:31:11PM +0300, Adalbert Laz=C4=83r wrote:
> > > VMAs obtained by mmap()ing memory access fds mirror the contents of t=
he remote
> > > process address space within the specified range. Pages are installed=
 in the
> > > current process page tables at fault time and removed by the mmu_inte=
rval_notifier
> > > invalidate callbck. No further memory management is involved.
> > > On attempts to access a hole, or if a mapping was removed by PIDFD_ME=
M_UNMAP,
> > > or if the remote process address space was reaped by OOM, the remote =
mapping
> > > fault handler returns VM_FAULT_SIGBUS.
> >=20
> > I still think anything along these lines needs to meet the XPMEM use
> > cases as well, we have to have more general solutions for such MM
> > stuff:
> >=20
> > https://gitlab.com/hjelmn/xpmem
> >=20
> > However, I think this fundamentally falls into some of the same bad
> > direction as xpmem.
> >=20
> > I would much rather see this design copy & clone the VMA's than try to
> > mirror the PTEs inside the VMAs from the remote into a single giant
> > VMA and somehow split/mirror the VMA ops.
>=20
> I'm on holiday for the next few days, but does the mshare() API work for
> your use case?
>=20
> Proposal: http://www.wil.cx/~willy/linux/sileby.html
> Start at implementation:
> http://git.infradead.org/users/willy/linux.git/shortlog/refs/heads/mshare

I found some interest in this project here, with the detail that
pin_user_pages() should keep working, ideally on both sides of the
share, but essentially on the side that calls mshare()

Maybe we can help out, at least cc me if you make progress :)

Thanks,
Jason
