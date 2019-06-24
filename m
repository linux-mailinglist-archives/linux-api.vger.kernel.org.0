Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D37C951D14
	for <lists+linux-api@lfdr.de>; Mon, 24 Jun 2019 23:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbfFXV1u (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Jun 2019 17:27:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14558 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726331AbfFXV1t (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 24 Jun 2019 17:27:49 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OLNn6I117520
        for <linux-api@vger.kernel.org>; Mon, 24 Jun 2019 17:27:48 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tb6arg9jn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-api@vger.kernel.org>; Mon, 24 Jun 2019 17:27:47 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-api@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 24 Jun 2019 22:27:44 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Jun 2019 22:27:40 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5OLRdCl50462832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 21:27:39 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70859A4057;
        Mon, 24 Jun 2019 21:27:39 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68810A4040;
        Mon, 24 Jun 2019 21:27:38 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Jun 2019 21:27:38 +0000 (GMT)
Subject: Re: [PATCH V31 07/25] kexec_file: Restrict at runtime if the kernel
 is locked down
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>, Dave Young <dyoung@redhat.com>
Cc:     James Morris <jmorris@namei.org>, Jiri Bohac <jbohac@suse.cz>,
        Linux API <linux-api@vger.kernel.org>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Date:   Mon, 24 Jun 2019 17:27:37 -0400
In-Reply-To: <CACdnJusPtYLdg7ZPhBo=Y5EsBz6B+5M2zYscBrLcc89oNnPkdQ@mail.gmail.com>
References: <20190326182742.16950-1-matthewgarrett@google.com>
         <20190326182742.16950-8-matthewgarrett@google.com>
         <20190621064340.GB4528@localhost.localdomain>
         <CACdnJut=J1YTpM4s6g5XWCEs+=X0Jvf8otfMg+w=_oqSZmf01Q@mail.gmail.com>
         <20190624015206.GB2976@dhcp-128-65.nay.redhat.com>
         <CACdnJusPtYLdg7ZPhBo=Y5EsBz6B+5M2zYscBrLcc89oNnPkdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19062421-0008-0000-0000-000002F6A77A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062421-0009-0000-0000-00002263D4EA
Message-Id: <1561411657.4340.70.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240169
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Matthew,

On Mon, 2019-06-24 at 14:06 -0700, Matthew Garrett wrote:
> On Sun, Jun 23, 2019 at 6:52 PM Dave Young <dyoung@redhat.com> wrote:
> >
> > On 06/21/19 at 01:18pm, Matthew Garrett wrote:
> > > I don't think so - we want it to be possible to load images if they
> > > have a valid signature.
> >
> > I know it works like this way because of the previous patch.  But from
> > the patch log "When KEXEC_SIG is not enabled, kernel should not load
> > images", it is simple to check it early for !IS_ENABLED(CONFIG_KEXEC_SIG) &&
> > kernel_is_locked_down(reason, LOCKDOWN_INTEGRITY)  instead of depending
> > on the late code to verify signature.  In that way, easier to
> > understand the logic, no?
> 
> But that combination doesn't enforce signature validation? We can't
> depend on !IS_ENABLED(CONFIG_KEXEC_SIG_FORCE) because then it'll
> enforce signature validation even if lockdown is disabled.

I agree with Dave.  There should be a stub lockdown function to
prevent enforcing lockdown when it isn't enabled.

Mimi

