Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 892A74F0C9
	for <lists+linux-api@lfdr.de>; Sat, 22 Jun 2019 00:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfFUWbf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jun 2019 18:31:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726224AbfFUWbf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Jun 2019 18:31:35 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LMVXYX123325
        for <linux-api@vger.kernel.org>; Fri, 21 Jun 2019 18:31:34 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t975s1s2f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-api@vger.kernel.org>; Fri, 21 Jun 2019 18:31:33 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-api@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 21 Jun 2019 23:31:30 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Jun 2019 23:31:28 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5LMVRPH63242380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jun 2019 22:31:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A4815209F;
        Fri, 21 Jun 2019 22:31:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.81.152])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 33A80520A0;
        Fri, 21 Jun 2019 22:31:26 +0000 (GMT)
Subject: Re: [PATCH V33 03/30] security: Add a static lockdown policy LSM
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <matthewgarrett@google.com>, jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>
Date:   Fri, 21 Jun 2019 18:31:15 -0400
In-Reply-To: <20190621011941.186255-4-matthewgarrett@google.com>
References: <20190621011941.186255-1-matthewgarrett@google.com>
         <20190621011941.186255-4-matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19062122-0008-0000-0000-000002F5F4F4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062122-0009-0000-0000-000022631B2F
Message-Id: <1561156275.4057.154.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906210172
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 2019-06-20 at 18:19 -0700, Matthew Garrett wrote:

> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2239,6 +2239,15 @@
>  	lockd.nlm_udpport=M	[NFS] Assign UDP port.
>  			Format: <integer>
>  
> +	lockdown=	[SECURITY]
> +			{ integrity | confidentiality }
> +			Enable the kernel lockdown feature. If set to
> +			integrity, kernel features that allow userland to
> +			modify the running kernel are disabled. If set to
> +			confidentiality, kernel features that allow userland
> +			to extract confidential information from the kernel
> +			are also disabled.
> +

Does "also" imply "integrity" is a prereq for "confidentiality"?

> diff --git a/security/lockdown/Kconfig b/security/lockdown/Kconfig
> new file mode 100644
> index 000000000000..431cd2b9a14e
> --- /dev/null
> +++ b/security/lockdown/Kconfig
> @@ -0,0 +1,46 @@
> +config SECURITY_LOCKDOWN_LSM
> +	bool "Basic module for enforcing kernel lockdown"
> +	depends on SECURITY
> +	help
> +	  Build support for an LSM that enforces a coarse kernel lockdown
> +	  behaviour.
> +
> +config SECURITY_LOCKDOWN_LSM_EARLY
> +        bool "Enable lockdown LSM early in init"
> +	depends on SECURITY_LOCKDOWN_LSM
> +	help
> +	  Enable the lockdown LSM early in boot. This is necessary in order
> +	  to ensure that lockdown enforcement can be carried out on kernel
> +	  boot parameters that are otherwise parsed before the security
> +	  subsystem is fully initialised.
> +
> +choice
> +	prompt "Kernel default lockdown mode"
> +	default LOCK_DOWN_KERNEL_FORCE_NONE
> +	depends on SECURITY_LOCKDOWN_LSM
> +	help
> +	  The kernel can be configured to default to differing levels of
> +	  lockdown.
> +
> +config LOCK_DOWN_KERNEL_FORCE_NONE
> +       bool "None"
> +       help
> +          No lockdown functionality is enabled by default. Lockdown may be
> +	  enabled via the kernel commandline or /sys/kernel/security/lockdown.
> +
> +config LOCK_DOWN_KERNEL_FORCE_INTEGRITY
> +       bool "Integrity"
> +       help
> +         The kernel runs in integrity mode by default. Features that allow
> +	 the kernel to be modified at runtime are disabled.
> +
> +config LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY
> +       bool "Confidentiality"
> +       help
> +         The kernel runs in confidentiality mode by default. Features that
> +	 allow the kernel to be modified at runtime or that permit userland
> +	 code to read confidential material held inside the kernel are
> +	 disabled.
> +

Is there a missing dependency on LOCK_DOWN_KERNEL_FORCE_INTEGRITY
here?

> +endchoice
> +


> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> new file mode 100644
> index 000000000000..1ecb2eecb245
> --- /dev/null
> +++ b/security/lockdown/lockdown.c

> +
> +static int __init lockdown_lsm_init(void)
> +{
> +#if defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY)
> +	lock_kernel_down("Kernel configuration", LOCKDOWN_INTEGRITY_MAX);
> +#elif defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY)
> +	lock_kernel_down("Kernel configuration", LOCKDOWN_CONFIDENTIALITY_MAX);
> +#endif
> +	security_add_hooks(lockdown_hooks, ARRAY_SIZE(lockdown_hooks),
> +			   "lockdown");
> +	return 0;
> +}

If there is a dependency on
"defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY" for
"CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY", then the ordering
should be reversed.  If there isn't a dependency of one on the other,
then replace the "elif" with "endif".

Mimi

