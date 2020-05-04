Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936D81C3FCD
	for <lists+linux-api@lfdr.de>; Mon,  4 May 2020 18:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgEDQ2n (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 4 May 2020 12:28:43 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33518 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgEDQ2n (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 4 May 2020 12:28:43 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jVdxR-0002Ya-MZ; Mon, 04 May 2020 10:28:41 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jVdxF-0002fk-2W; Mon, 04 May 2020 10:28:41 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?utf-8?Q?St=C3=A9phane?= Graber <stgraber@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Serge Hallyn <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org
References: <20200504144141.3605533-1-christian.brauner@ubuntu.com>
        <20200504144141.3605533-3-christian.brauner@ubuntu.com>
Date:   Mon, 04 May 2020 11:25:07 -0500
In-Reply-To: <20200504144141.3605533-3-christian.brauner@ubuntu.com>
        (Christian Brauner's message of "Mon, 4 May 2020 16:41:40 +0200")
Message-ID: <87h7wvoefw.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jVdxF-0002fk-2W;;;mid=<87h7wvoefw.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19fC77YDZ/s6OgFRdJGwh3qJWiJoBgKLuI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4602]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 237 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (4.9%), b_tie_ro: 10 (4.3%), parse: 1.25
        (0.5%), extract_message_metadata: 2.9 (1.2%), get_uri_detail_list:
        0.53 (0.2%), tests_pri_-1000: 3.6 (1.5%), tests_pri_-950: 1.21 (0.5%),
        tests_pri_-900: 1.02 (0.4%), tests_pri_-90: 84 (35.5%), check_bayes:
        83 (34.9%), b_tokenize: 4.4 (1.8%), b_tok_get_all: 4.5 (1.9%),
        b_comp_prob: 1.54 (0.6%), b_tok_touch_all: 69 (29.2%), b_finish: 0.92
        (0.4%), tests_pri_0: 116 (48.7%), check_dkim_signature: 0.45 (0.2%),
        check_dkim_adsp: 2.4 (1.0%), poll_dns_idle: 0.86 (0.4%), tests_pri_10:
        2.0 (0.9%), tests_pri_500: 6 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 2/3] nsproxy: attach to namespaces via pidfds
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


I am not thrilled about treating nstype as a flags fields when it is not
currently.  It was my hope when I designed the interface that not
treating nstype as a flags field would save us from the problem of bits
running out.

That aside.  It would be very good if the default version of setting
everything from a pidfd would set the root directory from the process it
is copying everything else from.

Eric
