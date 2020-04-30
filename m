Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786DD1C046E
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2020 20:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgD3SMw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Apr 2020 14:12:52 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:35986 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgD3SMv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 Apr 2020 14:12:51 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jUDg0-0000n9-R9; Thu, 30 Apr 2020 12:12:48 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jUDfz-0005Zd-NS; Thu, 30 Apr 2020 12:12:48 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?utf-8?Q?St=C3=A9phane?= Graber <stgraber@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Serge Hallyn <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org
References: <20200430165717.1001605-1-christian.brauner@ubuntu.com>
Date:   Thu, 30 Apr 2020 13:09:30 -0500
In-Reply-To: <20200430165717.1001605-1-christian.brauner@ubuntu.com>
        (Christian Brauner's message of "Thu, 30 Apr 2020 18:57:14 +0200")
Message-ID: <87y2qczvz9.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jUDfz-0005Zd-NS;;;mid=<87y2qczvz9.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/2u92/HUnzulG8cj3qAG1mxVp6CYsuNXk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 616 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.7%), b_tie_ro: 9 (1.5%), parse: 1.49 (0.2%),
         extract_message_metadata: 24 (3.8%), get_uri_detail_list: 3.3 (0.5%),
        tests_pri_-1000: 22 (3.5%), tests_pri_-950: 1.21 (0.2%),
        tests_pri_-900: 0.96 (0.2%), tests_pri_-90: 94 (15.3%), check_bayes:
        93 (15.1%), b_tokenize: 9 (1.5%), b_tok_get_all: 13 (2.1%),
        b_comp_prob: 2.4 (0.4%), b_tok_touch_all: 64 (10.4%), b_finish: 0.89
        (0.1%), tests_pri_0: 440 (71.4%), check_dkim_signature: 0.52 (0.1%),
        check_dkim_adsp: 2.2 (0.4%), poll_dns_idle: 0.50 (0.1%), tests_pri_10:
        3.4 (0.5%), tests_pri_500: 15 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 1/4] capability: add ns_capable_cred()
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> Add a simple capability helper which makes it possible to determine
> whether a set of creds is ns capable wrt to the passed in credentials.
> This is not something exciting it's just a more pleasant wrapper around
> security_capable() by allowing ns_capable_common() to ake a const struct
> cred argument. In ptrace_has_cap() for example, we're using
> security_capable() directly. ns_capable_cred() will be used in the next
> patch to check against the target credentials the caller is going to
> switch to.

Given that this is to suppot setns.  I don't understand the
justification for this.

Is it your intention to use the reduced permissions that you get
when you install a user namespace?

Why do you want to use the reduced permissions when installing multiple
namespaces at once?

Eric


> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* v2 */
> patch introduced
> ---
>  include/linux/capability.h |  3 +++
>  kernel/capability.c        | 17 +++++++++++------
>  2 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index ecce0f43c73a..743a08d936fb 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -40,6 +40,7 @@ struct cpu_vfs_cap_data {
>  struct file;
>  struct inode;
>  struct dentry;
> +struct cred;
>  struct task_struct;
>  struct user_namespace;
>  
> @@ -209,6 +210,8 @@ extern bool has_ns_capability_noaudit(struct task_struct *t,
>  				      struct user_namespace *ns, int cap);
>  extern bool capable(int cap);
>  extern bool ns_capable(struct user_namespace *ns, int cap);
> +extern bool ns_capable_cred(const struct cred *cred,
> +			    struct user_namespace *ns, int cap);
>  extern bool ns_capable_noaudit(struct user_namespace *ns, int cap);
>  extern bool ns_capable_setid(struct user_namespace *ns, int cap);
>  #else
> diff --git a/kernel/capability.c b/kernel/capability.c
> index 1444f3954d75..84425781917e 100644
> --- a/kernel/capability.c
> +++ b/kernel/capability.c
> @@ -361,8 +361,8 @@ bool has_capability_noaudit(struct task_struct *t, int cap)
>  	return has_ns_capability_noaudit(t, &init_user_ns, cap);
>  }
>  
> -static bool ns_capable_common(struct user_namespace *ns,
> -			      int cap,
> +static bool ns_capable_common(const struct cred *cred,
> +			      struct user_namespace *ns, int cap,
>  			      unsigned int opts)
>  {
>  	int capable;
> @@ -372,7 +372,7 @@ static bool ns_capable_common(struct user_namespace *ns,
>  		BUG();
>  	}
>  
> -	capable = security_capable(current_cred(), ns, cap, opts);
> +	capable = security_capable(cred, ns, cap, opts);
>  	if (capable == 0) {
>  		current->flags |= PF_SUPERPRIV;
>  		return true;
> @@ -393,10 +393,15 @@ static bool ns_capable_common(struct user_namespace *ns,
>   */
>  bool ns_capable(struct user_namespace *ns, int cap)
>  {
> -	return ns_capable_common(ns, cap, CAP_OPT_NONE);
> +	return ns_capable_common(current_cred(), ns, cap, CAP_OPT_NONE);
>  }
>  EXPORT_SYMBOL(ns_capable);
>  
> +bool ns_capable_cred(const struct cred *cred, struct user_namespace *ns, int cap)
> +{
> +	return ns_capable_common(cred, ns, cap, CAP_OPT_NONE);
> +}
> +
>  /**
>   * ns_capable_noaudit - Determine if the current task has a superior capability
>   * (unaudited) in effect
> @@ -411,7 +416,7 @@ EXPORT_SYMBOL(ns_capable);
>   */
>  bool ns_capable_noaudit(struct user_namespace *ns, int cap)
>  {
> -	return ns_capable_common(ns, cap, CAP_OPT_NOAUDIT);
> +	return ns_capable_common(current_cred(), ns, cap, CAP_OPT_NOAUDIT);
>  }
>  EXPORT_SYMBOL(ns_capable_noaudit);
>  
> @@ -430,7 +435,7 @@ EXPORT_SYMBOL(ns_capable_noaudit);
>   */
>  bool ns_capable_setid(struct user_namespace *ns, int cap)
>  {
> -	return ns_capable_common(ns, cap, CAP_OPT_INSETID);
> +	return ns_capable_common(current_cred(), ns, cap, CAP_OPT_INSETID);
>  }
>  EXPORT_SYMBOL(ns_capable_setid);
>  
>
> base-commit: ae83d0b416db002fe95601e7f97f64b59514d936
