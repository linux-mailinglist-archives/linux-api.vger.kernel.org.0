Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA84A392F
	for <lists+linux-api@lfdr.de>; Fri, 30 Aug 2019 16:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfH3O0d (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 30 Aug 2019 10:26:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727751AbfH3O0d (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 30 Aug 2019 10:26:33 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7UEIFZ2004784
        for <linux-api@vger.kernel.org>; Fri, 30 Aug 2019 10:26:32 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uq2qjpev0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-api@vger.kernel.org>; Fri, 30 Aug 2019 10:26:31 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-api@vger.kernel.org> from <prudo@linux.ibm.com>;
        Fri, 30 Aug 2019 15:26:28 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 30 Aug 2019 15:26:24 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7UEQNcA60489974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 14:26:23 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E73E52050;
        Fri, 30 Aug 2019 14:26:23 +0000 (GMT)
Received: from laptop-ibm (unknown [9.152.212.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 051935204E;
        Fri, 30 Aug 2019 14:26:22 +0000 (GMT)
Date:   Fri, 30 Aug 2019 16:26:22 +0200
From:   Philipp Rudo <prudo@linux.ibm.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, Jiri Bohac <jbohac@suse.cz>,
        linux-api@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH V40 08/29] kexec_file: split KEXEC_VERIFY_SIG into
 KEXEC_SIG and KEXEC_SIG_FORCE
In-Reply-To: <20190820001805.241928-9-matthewgarrett@google.com>
References: <20190820001805.241928-1-matthewgarrett@google.com>
        <20190820001805.241928-9-matthewgarrett@google.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19083014-0008-0000-0000-0000030F0C7D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19083014-0009-0000-0000-00004A2D5471
Message-Id: <20190830162622.534a0b8f@laptop-ibm>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-30_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908300147
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Matthew,

found a typo ...

On Mon, 19 Aug 2019 17:17:44 -0700
Matthew Garrett <matthewgarrett@google.com> wrote:

[...]

> index 6d0635ceddd0..9b4f37a4edf1 100644
> --- a/arch/s390/kernel/kexec_elf.c
> +++ b/arch/s390/kernel/kexec_elf.c
> @@ -130,7 +130,7 @@ static int s390_elf_probe(const char *buf, unsigned long len)
>  const struct kexec_file_ops s390_kexec_elf_ops = {
>  	.probe = s390_elf_probe,
>  	.load = s390_elf_load,
> -#ifdef CONFIG_KEXEC_VERIFY_SIG
> +#ifdef CONFIG_KEXEC__SIG
		      ^^
... here.
>  	.verify_sig = s390_verify_sig,
> -#endif /* CONFIG_KEXEC_VERIFY_SIG */
> +#endif /* CONFIG_KEXEC_SIG */
>  };

Thanks
Philipp

